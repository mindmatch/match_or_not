defmodule MatchOrNot.Repo.Migrations.CreateTalent do
  use Ecto.Migration

  def change do
    create table(:talents) do
      add :resume, :map

      timestamps()
    end

  end
end
