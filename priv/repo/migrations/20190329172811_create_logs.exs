defmodule LogServer.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :name, :string
      add :user_id, :integer
      add :type, :string

      timestamps()
    end

  end
end
