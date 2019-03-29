defmodule LogServer.Repo.Migrations.CreateEnvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :quantity, :float
      add :log_id, :integer

      timestamps()
    end

  end
end
