defmodule Sportpal.Repo.Migrations.UsersTableSportsColTypeChange do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :sports, {:array, :string}
      remove :availability, :string
    end

    flush()

    alter table(:users) do
      add :sports, :map
      add :availability, {:array, :string}
    end
  end
end
