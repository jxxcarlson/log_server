  defmodule LogServer.Logs.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :name, :string
    field :log_type, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:name, :user_id, :log_type])
    |> validate_required([:name, :user_id, :log_type])
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
