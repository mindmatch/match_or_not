defmodule MatchOrNot.Repo.Migrations.CreateJob do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :description, :map

      timestamps()
    end

  end
end
