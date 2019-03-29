defmodule LogServerWeb.PageController do
  use LogServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
