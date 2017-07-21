defmodule MatchOrNot.Feedback do
  use MatchOrNot.Web, :model

  schema "feedbacks" do
    field :username, :string
    field :feedback, :boolean, default: false
    belongs_to :score, MatchOrNot.Score

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :feedback])
    |> validate_required([:username, :feedback])
  end
end
