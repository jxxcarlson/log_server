

defmodule LogServerWeb.Resolvers.UserResolver do
  @moduledoc false

  alias LogServer.Repo
  alias LogServer.Accounts.User


  def get_user(_root, %{id: id}, _resolution) do
    {:ok, Repo.get_by(User, id: id)}
  end

  def list_users(_root, _args, _info) do
    {:ok, Repo.all User}
  end

  def create_log(_root, args, _info) do
    # TODO: add detailed error message handling later
    case User.create_log(args) do
      {:ok, user} ->
        {:ok, user}
      _error ->
        {:error, "could not create log"}
    end
  end


end
