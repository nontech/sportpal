defmodule Sportpal.Repo.Migrations.CreateInvitations do
  use Ecto.Migration

  def up do
    create table(:invitations) do
      add(:inquiry_id, references("inquiries"))
      add(:from_id, references("users"))
      add(:from_decision, :string, default: "")
      add(:to_id, references("users"))
      add(:to_decision, :string, default: "")

      timestamps()
    end
  end

  def down do
    drop table(:invitations)
  end
end
