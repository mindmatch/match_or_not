defmodule MatchOrNot.JobTest do
  use MatchOrNot.ModelCase

  alias MatchOrNot.Job

  @valid_attrs %{description: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, @invalid_attrs)
    refute changeset.valid?
  end
end
