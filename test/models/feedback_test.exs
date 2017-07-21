defmodule MatchOrNot.FeedbackTest do
  use MatchOrNot.ModelCase

  alias MatchOrNot.Feedback

  @valid_attrs %{feedback: true, username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Feedback.changeset(%Feedback{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feedback.changeset(%Feedback{}, @invalid_attrs)
    refute changeset.valid?
  end
end
