  defmodule LogServer.Logs.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :name, :string
    field :type, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:name, :user_id, :type])
    |> validate_required([:name, :user_id, :type])
  end

end
