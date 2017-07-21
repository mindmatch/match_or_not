defmodule MatchOrNot.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :username, :string
      add :feedback, :boolean, default: false, null: false
      add :score_id, references(:scores, on_delete: :nothing)

      timestamps()
    end
    create index(:feedbacks, [:score_id])

  end
end
