defmodule Sportpal.Repo.Migrations.ModifyUsersTable do
  use Ecto.Migration

  def up do
    alter table("users") do
      add(:full_name, :string)
      add(:profile_pic, :string)
      add(:city, :string)
      add(:country, :string)
      add(:availability, :string)
      remove(:location)
    end

    rename table("users"), :interests, to: :sports
  end

  def down do
    alter table("users") do
      remove(:full_name)
      remove(:profile_pic)
      remove(:city)
      remove(:country)
      remove(:availability)
      add(:location, :string)
    end

    rename table("users"), :sports, to: :interests
  end
end
