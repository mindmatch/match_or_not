defmodule MatchOrNot.TalentTest do
  use MatchOrNot.ModelCase

  alias MatchOrNot.Talent

  @valid_attrs %{resume: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Talent.changeset(%Talent{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Talent.changeset(%Talent{}, @invalid_attrs)
    refute changeset.valid?
  end
end
