defmodule LogServerWeb.EventController do
  use LogServerWeb, :controller

  alias LogServer.Logs
  alias LogServer.Logs.Event

  action_fallback LogServerWeb.FallbackController

  def index(conn, _params) do
    envents = Logs.list_envents()
    render(conn, "index.json", envents: envents)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Logs.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Logs.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Logs.get_event!(id)

    with {:ok, %Event{} = event} <- Logs.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Logs.get_event!(id)

    with {:ok, %Event{}} <- Logs.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
