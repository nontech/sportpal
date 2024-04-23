defmodule Sportpal.Repo.Migrations.CreateApplicationsTable do
  use Ecto.Migration

  def change do
    create table("applications") do
      add :applicant_user_id, references(:users, on_delete: :nothing), null: false
      add :offer_id, references(:offers, on_delete: :nothing), null: false
      add :skill_level, :integer
      add :accepted, :boolean

      timestamps()
    end
  end
end
