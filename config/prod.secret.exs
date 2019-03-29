use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :log_server, LogServerWeb.Endpoint,
  secret_key_base: "hx3+1Rl+VXUO9dCFxtVTlpR2j0DueCW6kCDmjJ59rbflPzq00R2fd5GWMv6sjuoe"

# Configure your database
config :log_server, LogServer.Repo,
  username: "postgres",
  password: "postgres",
  database: "log_server_prod",
  pool_size: 15
