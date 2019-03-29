defmodule LogServer.LogsTest do
  use LogServer.DataCase

  alias LogServer.Logs

  describe "logs" do
    alias LogServer.Logs.Log

    @valid_attrs %{name: "some name", type: "some type", user_id: 42}
    @update_attrs %{name: "some updated name", type: "some updated type", user_id: 43}
    @invalid_attrs %{name: nil, type: nil, user_id: nil}

    def log_fixture(attrs \\ %{}) do
      {:ok, log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logs.create_log()

      log
    end

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert Logs.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert Logs.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      assert {:ok, %Log{} = log} = Logs.create_log(@valid_attrs)
      assert log.name == "some name"
      assert log.type == "some type"
      assert log.user_id == 42
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logs.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      assert {:ok, %Log{} = log} = Logs.update_log(log, @update_attrs)
      assert log.name == "some updated name"
      assert log.type == "some updated type"
      assert log.user_id == 43
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = Logs.update_log(log, @invalid_attrs)
      assert log == Logs.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = Logs.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Logs.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = Logs.change_log(log)
    end
  end

  describe "envents" do
    alias LogServer.Logs.Event

    @valid_attrs %{log_id: 42, quantity: 120.5}
    @update_attrs %{log_id: 43, quantity: 456.7}
    @invalid_attrs %{log_id: nil, quantity: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logs.create_event()

      event
    end

    test "list_envents/0 returns all envents" do
      event = event_fixture()
      assert Logs.list_envents() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Logs.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Logs.create_event(@valid_attrs)
      assert event.log_id == 42
      assert event.quantity == 120.5
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logs.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Logs.update_event(event, @update_attrs)
      assert event.log_id == 43
      assert event.quantity == 456.7
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Logs.update_event(event, @invalid_attrs)
      assert event == Logs.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Logs.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Logs.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Logs.change_event(event)
    end
  end
end
