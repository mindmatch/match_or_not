defmodule MatchOrNot.TalentController do
  use MatchOrNot.Web, :controller

  alias MatchOrNot.Talent

  def index(conn, _params) do
    talents = Repo.all(Talent)
    render(conn, "index.html", talents: talents)
  end

  def new(conn, _params) do
    changeset = Talent.changeset(%Talent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"talent" => talent_params}) do
    changeset = Talent.changeset(%Talent{}, talent_params)

    case Repo.insert(changeset) do
      {:ok, _talent} ->
        conn
        |> put_flash(:info, "Talent created successfully.")
        |> redirect(to: talent_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    talent = Repo.get!(Talent, id)
    render(conn, "show.html", talent: talent)
  end

  def edit(conn, %{"id" => id}) do
    talent = Repo.get!(Talent, id)
    changeset = Talent.changeset(talent)
    render(conn, "edit.html", talent: talent, changeset: changeset)
  end

  def update(conn, %{"id" => id, "talent" => talent_params}) do
    talent = Repo.get!(Talent, id)
    changeset = Talent.changeset(talent, talent_params)

    case Repo.update(changeset) do
      {:ok, talent} ->
        conn
        |> put_flash(:info, "Talent updated successfully.")
        |> redirect(to: talent_path(conn, :show, talent))
      {:error, changeset} ->
        render(conn, "edit.html", talent: talent, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    talent = Repo.get!(Talent, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(talent)

    conn
    |> put_flash(:info, "Talent deleted successfully.")
    |> redirect(to: talent_path(conn, :index))
  end
end
