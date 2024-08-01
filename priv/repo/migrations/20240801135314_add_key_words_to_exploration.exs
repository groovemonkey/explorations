defmodule Explorations.Repo.Migrations.AddKeyWordsToExploration do
  use Ecto.Migration

  def change do
    alter table(:explorations) do
      add :key_words, :string
    end
  end
end
