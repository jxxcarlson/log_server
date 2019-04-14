defmodule LogServer.Repo.Migrations.RenameEventFieldValueToUnit do
  use Ecto.Migration

  def change do
    rename table(:events), :value, to: :quantity
  end
end
