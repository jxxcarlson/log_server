defmodule LogServer.Logs.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias LogServer.Repo
  alias LogServer.Logs.Event

  # @primary_key {:id, :binary_id, autogenerate: true}

  schema "events" do
    field :log_id, :integer
    field :value, :float
    field :unit, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:value, :unit, :log_id])
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

  def convertEvents do
    Enum.map (Repo.all Event), (fn(event)  -> convert_event(event) end)
  end

  def convert_event(event) do
    if event.unit != nil do
      {newValue, ""} = Float.parse event.unit
      cs = changeset(event, %{ value: 60*newValue})
      Repo.update(cs)
    end
  end

end
