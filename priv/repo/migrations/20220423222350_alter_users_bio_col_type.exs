defmodule Sportpal.Repo.Migrations.AlterUsersBioColType do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :bio, :text
    end
  end
end
