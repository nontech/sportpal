defmodule Sportpal.Repo.Migrations.CreateUserSportsTable do
  use Ecto.Migration

  def change do
    create table("user_sports") do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :sports_id, references(:sports, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:user_sports, [:user_id, :sports_id])
  end
end
