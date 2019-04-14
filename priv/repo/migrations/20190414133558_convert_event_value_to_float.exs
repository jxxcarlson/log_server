defmodule LogServer.Repo.Migrations.ConvertEventValueToFloat do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :value2, :float
    end
  end
end
