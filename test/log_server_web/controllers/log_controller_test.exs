defmodule LogServerWeb.LogControllerTest do
  use LogServerWeb.ConnCase

  alias LogServer.Logs
  alias LogServer.Logs.Log

  @create_attrs %{
    name: "some name",
    type: "some type",
    user_id: 42
  }
  @update_attrs %{
    name: "some updated name",
    type: "some updated type",
    user_id: 43
  }
  @invalid_attrs %{name: nil, type: nil, user_id: nil}

  def fixture(:log) do
    {:ok, log} = Logs.create_log(@create_attrs)
    log
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all logs", %{conn: conn} do
      conn = get(conn, Routes.log_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create log" do
    test "renders log when data is valid", %{conn: conn} do
      conn = post(conn, Routes.log_path(conn, :create), log: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.log_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "type" => "some type",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.log_path(conn, :create), log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update log" do
    setup [:create_log]

    test "renders log when data is valid", %{conn: conn, log: %Log{id: id} = log} do
      conn = put(conn, Routes.log_path(conn, :update, log), log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.log_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "type" => "some updated type",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, log: log} do
      conn = put(conn, Routes.log_path(conn, :update, log), log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete log" do
    setup [:create_log]

    test "deletes chosen log", %{conn: conn, log: log} do
      conn = delete(conn, Routes.log_path(conn, :delete, log))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.log_path(conn, :show, log))
      end
    end
  end

  defp create_log(_) do
    log = fixture(:log)
    {:ok, log: log}
  end
end
