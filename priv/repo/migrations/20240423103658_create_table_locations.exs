defmodule Sportpal.Repo.Migrations.CreateTableLocations do
  use Ecto.Migration

  def change do
    create table("locations") do
      add :city, :string
      add :state, :string
      add :zip_code, :integer
      add :country, :string

      timestamps()
    end
  end
end
