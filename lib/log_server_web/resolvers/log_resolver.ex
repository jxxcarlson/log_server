defmodule LogServerWeb.Resolvers.LogResolver do
  @moduledoc false

  alias LogServer.Repo
  alias LogServer.Logs.Log
  alias LogServer.Logs


  def logs_for_user(_root, %{user_id: user_id}, _resolution) do
    {:ok, Repo.get_by(Log, user_id: user_id)}
  end

  def list_logs(_root, _args, _info) do
     {:ok, Repo.all Log}
  end

  def create_log(_root, args, _info) do
    # TODO: add detailed error message handling later
    case Logs.create_log(args) do
      {:ok, log} ->
        {:ok, log}
      _error ->
        {:error, "could not create log"}
    end
  end


end
