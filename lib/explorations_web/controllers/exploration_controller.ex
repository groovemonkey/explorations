defmodule ExplorationsWeb.ExplorationController do
  use ExplorationsWeb, :controller

  alias Explorations.Exploration
  alias Explorations.Explorations

  require Logger

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
        "" -> "random"
        _ -> city
      end

    Logger.info("Creating exploration for #{chosen_city}.")

    case Explorations.create_exploration(chosen_city) do
      {:ok, exploration} ->
        conn
        |> put_flash(:info, "Exploration created successfully.")
        |> redirect(to: ~p"/explorations/#{exploration}")

      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.error("Got a changeset back in create(): #{inspect(changeset)}")
        render(conn, :new, changeset: changeset)

      {:error, reason} ->
        Logger.error("Failed to create exploration: #{inspect(reason)}")

        conn
        |> put_flash(:error, "Failed to create exploration.")
        |> redirect(to: ~p"/random")
    end
  end

  def new(conn, _params) do
    changeset = Exploration.changeset(%Exploration{}, %{})
    render(conn, :new, changeset: changeset)
  end
end
