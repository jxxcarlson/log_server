defmodule LogServerWeb.EventView do
  use LogServerWeb, :view
  alias LogServerWeb.EventView

  def render("index.json", %{envents: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      quantity: event.quantity,
      log_id: event.log_id}
  end
end
