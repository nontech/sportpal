defmodule Sportpal.Repo.Migrations.UsersTableAlterSportsAvailability do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :sports
      remove :availability

      flush()

      add :sports, {:array, :string}
    end
  end
end
