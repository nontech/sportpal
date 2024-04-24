defmodule Sportpal.Offers.Offers do
  import Ecto.Query, warn: false
  alias Sportpal.Repo

  alias Sportpal.Offers.Offer

  # Offers: [
  #   %Sportpal.Offers.Offer{
  #     __meta__: ...,
  #     id: 1990,
  #     date: ~D[2024-07-02],
  #     creator_user_id: 1414,
  #     creator_user: #Sportpal.Accounts.User<
  #       __meta__: ...,
  #       id: 1414,
  #       email: ...,
  #       ...
  #     >,
  #     sport_id: 1606,
  #     sport: %Sportpal.Sports.Sport{
  #       __meta__: ...
  #       id: 1606,
  #       name: "tennis",
  #       skill_level: ...
  #       ...
  #     },
  #     location_id: 1094,
  #     location: %Sportpal.Locations.Location{
  #       __meta__: ...
  #       id: 1094,
  #       city: "Berlin",
  #       ...
  #   }
  # ]
  def get_all_offers_after_date(%{date: date, city: city, country: country} = _args) do
    query =
      from o in Offer,
        where: o.date >= ^date,
        join: l in assoc(o, :location),
        where: l.city == ^city and l.country == ^country,
        join: u in assoc(o, :creator_user),
        join: s in assoc(o, :sport),
        preload: [:creator_user, :sport, :location]

    Repo.all(query)
  end

  # def get_offers_by_sport(%{date: date, sport: sport, city: city, country: country} = _args) do
  #   query =
  #     from o in Offers,
  #       where: o.date >= ^date,
  #       join: l in assoc(o, :location),
  #       where: l.city == ^city and l.country == ^country,
  #       join: u in assoc(o, :creator_user),
  #       join: s in assoc(o, :sport),
  #       where: s.name == ^sport,
  #       preload: [:creator_user, :sport, :location]

  #   Repo.all(query)
  # end
end
