defmodule Sportpal.Locations.Location do
  use Ecto.Schema

  schema "locations" do
    field :city, :string
    field :state, :string
    field :zip_code, :integer
    field :country, :string

    timestamps()
  end
end
