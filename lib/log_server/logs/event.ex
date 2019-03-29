defmodule LogServer.Logs.Event do
  use Ecto.Schema
  import Ecto.Changeset

  # @primary_key {:id, :binary_id, autogenerate: true}

  schema "events" do
    field :log_id, :integer
    field :quantity, :float

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:quantity, :log_id])
    |> validate_required([:quantity, :log_id])
  end

end
