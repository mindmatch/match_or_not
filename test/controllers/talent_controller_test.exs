defmodule MatchOrNot.TalentControllerTest do
  use MatchOrNot.ConnCase

  alias MatchOrNot.Talent
  @valid_attrs %{resume: %{}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, talent_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing talents"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, talent_path(conn, :new)
    assert html_response(conn, 200) =~ "New talent"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, talent_path(conn, :create), talent: @valid_attrs
    assert redirected_to(conn) == talent_path(conn, :index)
    assert Repo.get_by(Talent, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, talent_path(conn, :create), talent: @invalid_attrs
    assert html_response(conn, 200) =~ "New talent"
  end

  test "shows chosen resource", %{conn: conn} do
    talent = Repo.insert! %Talent{}
    conn = get conn, talent_path(conn, :show, talent)
    assert html_response(conn, 200) =~ "Show talent"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, talent_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    talent = Repo.insert! %Talent{}
    conn = get conn, talent_path(conn, :edit, talent)
    assert html_response(conn, 200) =~ "Edit talent"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    talent = Repo.insert! %Talent{}
    conn = put conn, talent_path(conn, :update, talent), talent: @valid_attrs
    assert redirected_to(conn) == talent_path(conn, :show, talent)
    assert Repo.get_by(Talent, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    talent = Repo.insert! %Talent{}
    conn = put conn, talent_path(conn, :update, talent), talent: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit talent"
  end

  test "deletes chosen resource", %{conn: conn} do
    talent = Repo.insert! %Talent{}
    conn = delete conn, talent_path(conn, :delete, talent)
    assert redirected_to(conn) == talent_path(conn, :index)
    refute Repo.get(Talent, talent.id)
  end
end
