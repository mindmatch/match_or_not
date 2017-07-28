defmodule MatchOrNot.FeedbackController do
  use MatchOrNot.Web, :controller

  alias MatchOrNot.Feedback
  alias MatchOrNot.Score

  def index(conn, _params) do
    feedbacks = Repo.all(Feedback)
    render(conn, "index.html", feedbacks: feedbacks)
  end

  def new(conn, _params) do
    import Ecto.Query
    username = conn.cookies["username"]

    feedbacks = from f in Feedback, join: s in assoc(f, :score), select: %{job_id: s.job_id, score_id: f.score_id, username: f.username, id: f.id}
    if is_nil(username) do
      ids = []
      feedback_count_limit_query = from f in Feedback,
        join: s in assoc(f, :score),
        select: s.job_id,
        group_by: [s.job_id],
        having: count(f.id) >= 75
      job_ids = MatchOrNot.Repo.all(feedback_count_limit_query)
    else
      ids = MatchOrNot.Repo.all(from f in MatchOrNot.Feedback, where: f.username == ^username) |> Enum.map(&(&1.score_id))
      feedback_count_limit_query = from f in Feedback,
        join: s in assoc(f, :score),
        where: f.username == ^username,
        select: s.job_id,
        group_by: [s.job_id],
        having: count(f.id) >= 25
      job_ids = MatchOrNot.Repo.all(feedback_count_limit_query)
    end

    score_query = from s in Score,
      left_join: f in subquery(feedbacks), on: f.score_id == s.id,
      where: not s.id in ^ids,
      where: not s.job_id in ^job_ids,
      group_by: [s.id, s.score, s.job_id],
      having: count(f.id) < 1,
      #   having: count(f.job_id) < 25,
      limit: 1,
      preload: [:job, :talent, :feedbacks],
      order_by: [s.job_id, s.score, count(f.id)]

    score = Repo.all(score_query) |> List.first
    feedback = if score do
      %Feedback{score_id: score.id, username: username}
    else
      %Feedback{}
    end
    changeset = Feedback.changeset(feedback)
    render(conn, "new.html", changeset: changeset, score: score)
  end

  def create(conn, %{"feedback" => feedback_params}) do
    changeset = Feedback.changeset(%Feedback{}, feedback_params)

    case Repo.insert(changeset) do
      {:ok, _feedback} ->
        conn
        |> put_flash(:info, "Feedback created successfully.")
        |> put_resp_cookie("username", feedback_params["username"])
        |> redirect(to: feedback_path(conn, :new))
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
