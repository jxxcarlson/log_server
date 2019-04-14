defmodule LogServer.Logs.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias LogServer.Repo
  alias LogServer.Logs.Event

  # @primary_key {:id, :binary_id, autogenerate: true}

  schema "events" do
    field :log_id, :integer
    field :value, :string
    field :value2, :float

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:value, :value2, :log_id])
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
    {newValue, ""} = Float.parse event.value
    cs = changeset(event, %{value2: 60*newValue})
    Repo.update(cs)
  end

end
