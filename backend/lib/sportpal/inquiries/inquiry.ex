defmodule Sportpal.Inquiries.Inquiry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inquiries" do
    field(:city, :string, default: "")
    field(:country, :string, default: "")
    field(:sport, :string, default: "")
    field(:date, :date)
    field(:preferred_skill_level, :string, default: "")

    # one-to-one
    belongs_to(:user, Sportpal.Accounts.User)
    # one-to-one
    has_one(:invitation, Sportpal.Invitations.Invitation)

    timestamps()
  end

  @doc false
  def changeset(inquiry, attrs) do
    inquiry
    |> cast(attrs, [])
    |> validate_required([])
  end
end
