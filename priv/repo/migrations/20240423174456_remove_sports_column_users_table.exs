defmodule Sportpal.Repo.Migrations.RemoveSportsColumnUsersTable do
  use Ecto.Migration

  def change do
    # remove column
    alter table(:users) do
      remove :sports
    end
  end
end
