defmodule Explorations.Explorations do
  import Ecto.Query, warn: false
  alias Explorations.Repo
  alias Explorations.Exploration

  def list_explorations do
    Repo.all(Exploration)
  end

  def get_exploration!(id), do: Repo.get!(Exploration, id)

  def create_exploration(attrs \\ %{}) do
    %Exploration{}
    |> Exploration.changeset(attrs)
    |> Repo.insert()
  end

  def get_random_exploration do
    Exploration
    |> order_by(fragment("RANDOM()"))
    |> limit(1)
    |> Repo.one()
  end

  def get_random_exploration(city) do
    Exploration
    |> where(city: ^city)
    |> order_by(fragment("RANDOM()"))
    |> limit(1)
    |> Repo.one()
  end
end
