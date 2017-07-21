defmodule MatchOrNot.FeedbackController do
  use MatchOrNot.Web, :controller

  alias MatchOrNot.Feedback

  def index(conn, _params) do
    feedbacks = Repo.all(Feedback)
    render(conn, "index.html", feedbacks: feedbacks)
  end

  def new(conn, _params) do
    changeset = Feedback.changeset(%Feedback{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feedback" => feedback_params}) do
    changeset = Feedback.changeset(%Feedback{}, feedback_params)

    case Repo.insert(changeset) do
      {:ok, _feedback} ->
        conn
        |> put_flash(:info, "Feedback created successfully.")
        |> redirect(to: feedback_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feedback = Repo.get!(Feedback, id)
    render(conn, "show.html", feedback: feedback)
  end

  def edit(conn, %{"id" => id}) do
    feedback = Repo.get!(Feedback, id)
    changeset = Feedback.changeset(feedback)
    render(conn, "edit.html", feedback: feedback, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feedback" => feedback_params}) do
    feedback = Repo.get!(Feedback, id)
    changeset = Feedback.changeset(feedback, feedback_params)

    case Repo.update(changeset) do
      {:ok, feedback} ->
        conn
        |> put_flash(:info, "Feedback updated successfully.")
        |> redirect(to: feedback_path(conn, :show, feedback))
      {:error, changeset} ->
        render(conn, "edit.html", feedback: feedback, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feedback = Repo.get!(Feedback, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(feedback)

    conn
    |> put_flash(:info, "Feedback deleted successfully.")
    |> redirect(to: feedback_path(conn, :index))
  end
end
