# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :match_or_not,
  ecto_repos: [MatchOrNot.Repo]

# Configures the endpoint
config :match_or_not, MatchOrNot.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ImNKhtzK5zjPgddg2Akm5GIlCdhOhMMB79JtPt3kJ4UHuup43KI3Lge28U9mcnoA",
  render_errors: [view: MatchOrNot.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MatchOrNot.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
