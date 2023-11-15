defmodule Sportpal.Repo.Migrations.AddInquiryIdToInvitationsTable do
  use Ecto.Migration

  def change do
    alter table("invitations") do
      add(:inquiry_id, references("inquiries"))
    end
  end
end
