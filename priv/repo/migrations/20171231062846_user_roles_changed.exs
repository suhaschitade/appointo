defmodule Appointo.Repo.Migrations.UserRolesChanged do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :active, :boolean, default: true
    end
  end
end
