# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :log_server,
  ecto_repos: [LogServer.Repo]

# Configures the endpoint
config :log_server, LogServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FRhbgktc8c0f/+DpZuKkZbjXPi3GQpEZYfbxFjZt1GYP1E6bOaqgP6o3U2Q11kwh",
  render_errors: [view: LogServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LogServer.PubSub, adapter: Phoenix.PubSub.PG2],
  http: [port: System.get_env("PORT")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
