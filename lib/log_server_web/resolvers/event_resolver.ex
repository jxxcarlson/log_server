defmodule LogServerWeb.Resolvers.EventResolver do
  @moduledoc false

  alias LogServer.Repo
  alias LogServer.Logs.Event
  alias LogServer.Logs


  def list_events(_root, %{log_id: log_id}, _resolution) do
    {:ok, Repo.get_by(Event, log_id: log_id)}
  end

  def list_events(_root, _args, _info) do
    {:ok, Repo.all Event}
  end

  def create_event(_root, args, _info) do
    # TODO: add detailed error message handling later
    case Logs.create_event(args) do
      {:ok, event} ->
        {:ok, event}
      _error ->
        {:error, "could not create log"}
    end
  end


end
