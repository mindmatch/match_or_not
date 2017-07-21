defmodule MatchOrNot.Router do
  use MatchOrNot.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MatchOrNot do
    pipe_through :browser # Use the default browser stack

    get "/", FeedbackController, :new
    get "/about", PageController, :index
    resources "/feedbacks", FeedbackController
    resources "/scores", ScoreController
    resources "/talents", TalentController
    resources "/jobs", JobController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MatchOrNot do
  #   pipe_through :api
  # end
end
