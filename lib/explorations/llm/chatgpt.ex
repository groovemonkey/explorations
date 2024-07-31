defmodule Explorations.LLM.Chatgpt do
  require Logger

  def gpt_request(
        seed_prompt,
        user_text,
        opts \\ []
      ) do
    default_opts = [model: "gpt-4o-mini"]
    merged_opts = Keyword.merge(default_opts, opts)

    # Measure openAI request duration
    start_time = DateTime.now!("Etc/UTC")

    case OpenAI.chat_completion(
           model: merged_opts[:model],
           response_format: %{type: "json_object"},
           messages: [
             %{role: "system", content: seed_prompt},
             %{
               role: "user",
               content: user_text
             }
           ]
         ) do
      {:error, err} ->
        end_time = DateTime.utc_now()
        elapsed_time_ms = DateTime.diff(end_time, start_time, :millisecond)
        Logger.debug("gpt_request (error) took #{elapsed_time_ms}ms.")

        case err["error"]["type"] == "insufficient_quota" do
          true ->
            Logger.critical("ChatGPT quota exceeded: #{inspect(err)}")
            Jason.decode("%{}")

          _ ->
            Logger.error("Error returned from ChatGPT: #{inspect(err)}")
            {:error, err}
        end

      {:ok, resp} ->
        end_time = DateTime.now!("Etc/UTC")
        elapsed_time_ms = DateTime.diff(end_time, start_time, :millisecond)
        Logger.debug("ChatGPT response received after #{elapsed_time_ms}ms")

        Logger.debug(inspect(resp))

        Enum.at(resp.choices, 0)["message"]["content"]
        # returns {:ok, json}
        |> Jason.decode()
    end
  end
end
