defmodule MatchOrNot.Talent do
  use MatchOrNot.Web, :model

  schema "talents" do
    field :resume, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:resume])
    |> validate_required([:resume])
  end
end
