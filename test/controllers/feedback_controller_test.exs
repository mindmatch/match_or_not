defmodule MatchOrNot.FeedbackControllerTest do
  use MatchOrNot.ConnCase

  alias MatchOrNot.Feedback
  @valid_attrs %{feedback: true, username: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feedback_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing feedbacks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, feedback_path(conn, :new)
    assert html_response(conn, 200) =~ "New feedback"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, feedback_path(conn, :create), feedback: @valid_attrs
    assert redirected_to(conn) == feedback_path(conn, :index)
    assert Repo.get_by(Feedback, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feedback_path(conn, :create), feedback: @invalid_attrs
    assert html_response(conn, 200) =~ "New feedback"
  end

  test "shows chosen resource", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = get conn, feedback_path(conn, :show, feedback)
    assert html_response(conn, 200) =~ "Show feedback"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, feedback_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = get conn, feedback_path(conn, :edit, feedback)
    assert html_response(conn, 200) =~ "Edit feedback"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = put conn, feedback_path(conn, :update, feedback), feedback: @valid_attrs
    assert redirected_to(conn) == feedback_path(conn, :show, feedback)
    assert Repo.get_by(Feedback, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = put conn, feedback_path(conn, :update, feedback), feedback: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit feedback"
  end

  test "deletes chosen resource", %{conn: conn} do
    feedback = Repo.insert! %Feedback{}
    conn = delete conn, feedback_path(conn, :delete, feedback)
    assert redirected_to(conn) == feedback_path(conn, :index)
    refute Repo.get(Feedback, feedback.id)
  end
end
