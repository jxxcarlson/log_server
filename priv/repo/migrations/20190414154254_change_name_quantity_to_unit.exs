defmodule LogServer.Repo.Migrations.ChangeNameQuantityToUnit do
  use Ecto.Migration

  def change do
    rename table(:events), :quantity, to: :unit
  end
end
