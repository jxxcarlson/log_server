defmodule LogServer.Repo.Migrations.RenameEventFieldValue2ToValue do
  use Ecto.Migration

  def change do
    rename table(:events), :value2, to: :value
  end
end
