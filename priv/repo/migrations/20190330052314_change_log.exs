defmodule LogServer.Repo.Migrations.ChangeLog do
  use Ecto.Migration

  def change do
    rename table(:logs), :type, to: :log_type
  end
end
