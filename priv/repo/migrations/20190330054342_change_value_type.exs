defmodule LogServer.Repo.Migrations.ChangeValueType do
  use Ecto.Migration

  def change do
    alter table(:events) do
      modify :value, :string
    end

  end
end
