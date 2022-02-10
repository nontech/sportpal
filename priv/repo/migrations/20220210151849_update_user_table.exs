defmodule Sportpal.Repo.Migrations.UpdateUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :gender, :string
      add :location, :string
      add :bio, :string
      add :interests, {:array, :string}
      add :date_of_birth, :date
    end 
  end
end
