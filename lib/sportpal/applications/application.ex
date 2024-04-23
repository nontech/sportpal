defmodule Sportpal.Applications.Application do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applications" do
    field :skill_level, :integer
    field :accepted, :boolean, default: false

    # one-to-one
    belongs_to :applicant_user, Sportpal.Accounts.User
    belongs_to :offer, Sportpal.Offers.Offer

    timestamps()
  end
end
