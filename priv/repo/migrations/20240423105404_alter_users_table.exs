defmodule Sportpal.Repo.Migrations.AlterUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      # delete old fields
      remove_if_exists :bio, :string
      remove_if_exists :city, :string
      remove_if_exists :country, :string
      remove_if_exists :availability, {:array, :string}
      remove_if_exists :matching_partners, {:array, :integer}

      # add new fields
      add :location_id, references("locations", on_delete: :nothing)
    end
  end
end
