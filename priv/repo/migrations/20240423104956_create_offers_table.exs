defmodule Sportpal.Repo.Migrations.CreateOffersTable do
  use Ecto.Migration

  def change do
    create table("offers") do
      add :creator_user_id, references(:users, on_delete: :nothing), null: false
      add :sport_id, references(:sports, on_delete: :nothing), null: false
      add :location_id, references(:locations, on_delete: :nothing), null: false
      add :date, :date

      timestamps()
    end
  end
end
