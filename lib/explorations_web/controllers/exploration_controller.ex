defmodule ExplorationsWeb.ExplorationController do
  use ExplorationsWeb, :controller

  alias Explorations.Exploration
  alias Explorations.Explorations

  def index(conn, _params) do
    explorations = Explorations.list_explorations()
    render(conn, :index, explorations: explorations)
  end

  def show(conn, %{"id" => id}) do
    exploration = Explorations.get_exploration!(id)
    render(conn, :show, exploration: exploration)
  end

  def get_random(conn, %{"city" => city}) do
    exploration = Explorations.get_random_exploration(city)
    render(conn, :show, exploration: exploration)
  end

  def get_random(conn, _params) do
    exploration = Explorations.get_random_exploration()
    render(conn, :show, exploration: exploration)
  end

  def create(conn, %{"exploration" => %{"city" => city}} = _params) do
    chosen_city =
      case city do
        "" -> Enum.random(["New York", "Paris", "Tokyo", "London", "Sydney"])
        _ -> city
      end

    IO.puts("TODO: creating exploration for #{chosen_city}.")
    text = "This is a placeholder text for #{chosen_city}."
    exploration_params = %{city: chosen_city, text: text}

    case Explorations.create_exploration(exploration_params) do
      {:ok, exploration} ->
        conn
        |> put_flash(:info, "Exploration created successfully.")
        |> redirect(to: ~p"/explorations/#{exploration}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = Exploration.changeset(%Exploration{}, %{})
    render(conn, :new, changeset: changeset)
  end
end
