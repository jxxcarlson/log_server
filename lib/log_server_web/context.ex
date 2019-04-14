defmodule LogServerWeb.Context do
  @moduledoc false

  # https://github.com/absinthe-graphql/absinthe/blob/master/guides/context-and-authentication.md

  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call1(conn, _) do
    context = build_context(conn)
    with %{current_user: current_user} <- context do
      Absinthe.Plug.put_options(conn, context: context)
    else
      _ -> conn
         |> put_status(:unauthorized)
         |> Phoenix.Controller.put_view(LogServerWeb.ErrorView)
         |> Phoenix.Controller.render("error.json", %{error: "Could not authorize"})
         |> halt
    end

  end

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def extract_token(str) do
    String.replace_leading str, "Bearer ", ""
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
         %{current_user: current_user}
    else
      _ -> %{error: "authorization error"}
    end
  end


  def authorize(auth_token) do
    LogServer.Accounts.find_by_token(auth_token)
    |> case do
         nil  -> {:error, "Invalid authorization token"}
         {:ok, user} -> {:ok, user}
       end
  end



end
