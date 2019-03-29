defmodule LogServer.Repo do
  use Ecto.Repo,
    otp_app: :log_server,
    adapter: Ecto.Adapters.Postgres
end
