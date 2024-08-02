defmodule Explorations.Explorations do
  import Ecto.Query, warn: false
  require Logger
  alias Explorations.Repo
  alias Explorations.Exploration

  @prompt """
    I'd like you to create a fascinating Google Earth VR tour, consisting of addresses or points of interest, along with context, background, and other information.
    Here's what you should do: please come up with a “character” whose routine someone can follow to explore a place on google earth (especially google earth VR). Pick the following attributes:
    1. A city or town (will be given to you after this prompt).
    2. A plausible name and short background story/context for someone living there.
    3. Their socioeconomic class.
    4. A home where they might live (address).
    5. Where they work.
    6. Where they do recreational stuff — the park near their house, their favorite bar or restaurant, other things like that. all should be plausible and near enough to their home/work that it feels realistic. These places must be REAL locations/businesses/points of interest that exist and are findable on google maps.

    Put all of this into a format that’s easy to follow on google maps/google earth VR so people can explore this made-up person’s plausible “reality” as a kind of exploration/empathy game.

    Use your knowledge about the region/town/city to make the person’s life plausible — i.e. if they’re a worker at a small electronics factory in shenzhen, that’s very plausible or representative of the area.

    Return all data as a valid JSON object with the following fields. Put all locations you suggest into a list of locations on the object:
    {
      "city": "city name",
      "name": "character name",
      "background": "background story",
      "locations": [
        {
          address: "the address of the location, so readers can look it up on Google Streetview or Google Earth VR",
          description: "the rest of the information about this location -- context, etc."
        }
      ]
    }

    For example, for the prompt "Vienna, Austria", I'd like you to produce a valid JSON response like this:
    {"city": "Vienna, Austria","name": "Lena Schmid","background": "Lena is a 28-year-old graphic designer who grew up in the suburbs of Vienna. She moved to the city for university and fell in love with its rich history and vibrant art scene. Having recently scored a job at a small design studio, Lena is eager to share her artistic passion while also exploring the local culture and nightlife. A lover of traditional Viennese coffee houses, she enjoys relaxing with friends and drawing inspiration from her surroundings.","locations": [{"address": "Mariahilfer Str. 84, 1070 Wien, Austria","description": "Lena's apartment is located in the bustling 7th district, surrounded by shops and cafes. This lively neighborhood is known for its youthful energy and blends modernity with historic charm."},{"address": "Stadtpark, 1030 Wien, Austria","description": "Lena often visits Stadtpark, a large public park located near her home, to unwind and sketch. The park features beautiful gardens and statues, including the famous Johann Strauss monument, making it an ideal spot for creativity."},{"address": "Kaffeeküche, 1070 Wien, Austria","description": "A favorite coffee house of Lena's, Kaffeeküche offers a cozy atmosphere and delicious coffee options. She often meets friends here to catch up or work on her latest design projects while enjoying a slice of Sachertorte."},{"address": "Designa, Währinger Str. 26, 1090 Wien, Austria","description": "Lena works at Designa, a small design studio located in the artistic 9th district. The studio specializes in branding and digital design, allowing Lena to express her creativity alongside her talented colleagues."},{"address": "Hermannskeller, Gasthaus, 1090 Wien, Austria","description": "After a long week, Lena and her friends love to unwind at Hermannskeller, a traditional Viennese tavern that serves hearty food and local wines. The rustic décor and friendly atmosphere make it a perfect spot for relaxation."},{"address": "MuseumsQuartier, Museumsplatz 1, 1070 Wien, Austria","description": "An inspiring cultural complex, the MuseumsQuartier is a hub for contemporary art and creativity. Lena frequently visits the various galleries and outdoor events that take place here to soak in the local artistic vibe."}]}

       
    Please wait until my next prompt, which will either give you the name of a city to use as a starting point, or give you the string "random" which means you should pick a random place for the location.
    If "random" is selected, I may also give you a list of key words that the city you choose should match in some way. For example, "beach, sun, fun" might mean you should pick a city with a beach and a sunny climate.
    If a city name is given, and keywords are also passed, just ignore those key words.
  """

  @doc """
  This function returns the exploration with its text field formatted as a map
  """
  def format_exploration_text(exploration) do
    Map.put(
      exploration,
      :text,
      Jason.decode!(exploration.text)
    )
  end

  def list_explorations do
    Repo.all(Exploration)
  end

  def get_exploration!(id), do: format_exploration_text(Repo.get!(Exploration, id))

  def create_exploration(city, key_words) do
    prompt_with_key_words = @prompt <> " " <> "Keywords: #{key_words}"

    case Explorations.LLM.Chatgpt.gpt_request(prompt_with_key_words, city) do
      # response is a map (has been parsed by Jason library)
      {:ok, response} ->
        response_city = response["city"]
        string_for_now = Jason.encode!(response)

        %Exploration{}
        |> Exploration.changeset(%{city: response_city, text: string_for_now})
        |> Repo.insert()

      {:error, reason} ->
        Logger.error("create_exploration: got an error from chatGPT: #{inspect(reason)}")
        {:error, reason}

      wat ->
        Logger.error("Unexpected response from chatGPT: #{inspect(wat)}")
    end
  end

  def get_random_exploration do
    Exploration
    |> order_by(fragment("RANDOM()"))
    |> limit(1)
    |> Repo.one()
    |> format_exploration_text()
  end

  def get_random_exploration(city) do
    Exploration
    |> where(city: ^city)
    |> order_by(fragment("RANDOM()"))
    |> limit(1)
    |> Repo.one()
    |> format_exploration_text()
  end
end
