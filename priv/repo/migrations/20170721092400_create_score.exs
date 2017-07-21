defmodule MatchOrNot.Repo.Migrations.CreateScore do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :score, :float
      add :talent_id, references(:talents, on_delete: :nothing)
      add :job_id, references(:jobs, on_delete: :nothing)

      timestamps()
    end
    create index(:scores, [:talent_id])
    create index(:scores, [:job_id])

  end
end
