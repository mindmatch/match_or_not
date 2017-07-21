defmodule MatchOrNot.Job do
  use MatchOrNot.Web, :model

  schema "jobs" do
    field :description, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
  end
end
