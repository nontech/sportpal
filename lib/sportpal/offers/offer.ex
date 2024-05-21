defmodule Sportpal.Offers.Offer do
  use Ecto.Schema

  schema "offers" do
    field :date, :date

    # one-to-one
    belongs_to :creator_user, Sportpal.Accounts.User
    belongs_to :sport, Sportpal.Sports.Sport
    belongs_to :location, Sportpal.Locations.Location

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> Ecto.Changeset.cast(attrs, [:date, :location_id, :sport_id])
    |> Ecto.Changeset.validate_required([:date, :location_id, :sport_id])
  end
end
