defmodule MatchOrNot.Score do
  use MatchOrNot.Web, :model

  schema "scores" do
    field :score, :float
    belongs_to :talent, MatchOrNot.Talent
    belongs_to :job, MatchOrNot.Job
    has_many :feedbacks, MatchOrNot.Feedback

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:score])
    |> validate_required([:score])
  end
end
