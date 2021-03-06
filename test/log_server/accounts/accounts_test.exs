defmodule LogServer.AccountsTest do
  use LogServer.DataCase

  alias LogServer.Accounts

  describe "users" do
    alias LogServer.Accounts.User

    @valid_attrs %{admin: true, email: "some email", password: "some password", password_hash: "some password_hash", username: "some username", verified: true}
    @update_attrs %{admin: false, email: "some updated email", password: "some updated password", password_hash: "some updated password_hash", username: "some updated username", verified: false}
    @invalid_attrs %{admin: nil, email: nil, password: nil, password_hash: nil, username: nil, verified: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.admin == true
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.password_hash == "some password_hash"
      assert user.username == "some username"
      assert user.verified == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.admin == false
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.password_hash == "some updated password_hash"
      assert user.username == "some updated username"
      assert user.verified == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
