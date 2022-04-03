defmodule Sportpal.Repo.Migrations.CreateSportpalMatches do
  use Ecto.Migration

  def up do
    create table(:sportpal_matches) do
      add(:id)
      add(:sportpal_search_id)
      add(:initiator_id, references(:users))
      add(:initiator_decision, :string)
      add(:partner_id, references(:users))
      add(:partner_decision, :string)

      timestamps()
    end
  end

  def down do
    drop table(:sportpal_matches)
  end
end
