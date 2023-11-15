defmodule Sportpal.Repo.Migrations.AddMatchingPartners do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :matching_partners, {:array, :id}
    end
  end
end
