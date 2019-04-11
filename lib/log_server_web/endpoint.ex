defmodule LogServerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :log_server

  socket "/socket", LogServerWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :log_server,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Corsica,
       origins: ["https://138.197.81.6", "https://206.189.184.194", "http://localhost:8175"],
       log: [rejected: :error, invalid: :warn, accepted: :debug],
       allow_headers: ["content-type", "accept", "authorization"]

##origins: ["https://206.189.184.194", "http:/localhost:8175"],


  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_log_server_key",
    signing_salt: "L8GfiIiZ"

  plug LogServerWeb.Router
end
