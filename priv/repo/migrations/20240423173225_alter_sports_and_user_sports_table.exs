defmodule Sportpal.Repo.Migrations.AlterSportsAndUserSportsTable do
  use Ecto.Migration

  def change do
    # rename column
    rename table("user_sports"), :sports_id, to: :sport_id

    # remove column
    alter table(:sports) do
      remove_if_exists :sports, :jsonb
    end
  end
end
