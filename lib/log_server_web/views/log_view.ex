defmodule LogServerWeb.LogView do
  use LogServerWeb, :view
  alias LogServerWeb.LogView

  def render("index.json", %{logs: logs}) do
    %{data: render_many(logs, LogView, "log.json")}
  end

  def render("show.json", %{log: log}) do
    %{data: render_one(log, LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{id: log.id,
      name: log.name,
      user_id: log.user_id,
      type: log.type}
  end
end
