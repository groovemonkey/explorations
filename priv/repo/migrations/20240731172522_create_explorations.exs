defmodule Explorations.Repo.Migrations.CreateExplorations do
  use Ecto.Migration

  def change do
    create table(:explorations) do
      add :city, :string
      add :text, :text

      timestamps()
    end
  end
end
