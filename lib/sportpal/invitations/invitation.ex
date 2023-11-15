defmodule Sportpal.Invitations.Invitation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invitations" do
    field(:from_decision, :string, default: "")
    field(:to_decision, :string, default: "")

    # associations
    belongs_to(:from, Sportpal.Accounts.User)
    belongs_to(:to, Sportpal.Accounts.User)
    # one-to-one
    belongs_to(:inquiry, Sportpal.Inquiries.Inquiry)

    timestamps()
  end

  @doc false
  def changeset(invitation, attrs) do
    invitation
    |> cast(attrs, [])
    |> validate_required([])
  end
end
