defmodule Explorations.Exploration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "explorations" do
    field :text, :string
    field :city, :string

    timestamps()
  end

  @doc false
  def changeset(exploration, attrs) do
    exploration
    |> cast(attrs, [:city, :text])
    |> validate_required([:city, :text])
  end
end
