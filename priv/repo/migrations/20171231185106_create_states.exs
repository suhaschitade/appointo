defmodule Appointo.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string
      add :twolettercode, :string
      add :threelettercode, :string
      add :active, :boolean, default: false, null: false
      add :country_id, references(:countries)
      timestamps()
    end

  end
end
