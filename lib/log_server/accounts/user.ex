defmodule LogServer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password, :string
    field :password_hash, :string
    field :username, :string
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :admin, :verified, :password, :password_hash])
    |> validate_required([:username, :email, :admin, :verified, :password, :password_hash])
  end
end
