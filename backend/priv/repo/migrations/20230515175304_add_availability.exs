defmodule Sportpal.Repo.Migrations.AddAvailability do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :availability, {:array, :string}
    end
  end
end
