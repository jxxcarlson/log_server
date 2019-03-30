defmodule LogServer.Repo.Migrations.ChangeQuantityToValue do
  use Ecto.Migration

  def change do
    rename table(:events), :quantity, to: :value
  end
end
