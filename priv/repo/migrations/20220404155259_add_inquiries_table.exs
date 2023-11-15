defmodule Sportpal.Repo.Migrations.AddInquiriesTable do
  use Ecto.Migration

  def up do
    create table(:inquiries) do
      add(:user_id, references("users"))
      add(:city, :string, default: "")
      add(:country, :string, default: "")
      add(:sport, :string, default: "")
      add(:date, :date)
      add(:preferred_skill_level, :string, default: "")

      timestamps()
    end
  end

  def down do
    drop table(:inquiries)
  end
end
