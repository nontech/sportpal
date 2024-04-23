defmodule Sportpal.Repo.Migrations.CreateSportsTable do
  use Ecto.Migration

  def change do
    create table("sports") do
      add :name, :string
      add :skill_level, :integer

      timestamps()
    end
  end
end
