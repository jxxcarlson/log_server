defmodule LogServer.Logs.Event do
  use Ecto.Schema
  import Ecto.Changeset

  # @primary_key {:id, :binary_id, autogenerate: true}

  schema "events" do
    field :log_id, :integer
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:value, :log_id])
    |> validate_required([:value, :log_id])
  end

  @doc "Dataloader"
  def data() do
    Dataloader.Ecto.new(LogServer.Repo, query: &query/2)
  end

  @doc "Dataloader"
  def query(queryable, _params) do
    queryable
  end

end
