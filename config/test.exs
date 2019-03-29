use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :log_server, LogServerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :log_server, LogServer.Repo,
  username: "postgres",
  password: "postgres",
  database: "log_server_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
