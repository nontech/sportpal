defmodule Sportpal.Offers.Offers do
  import Ecto.Query, warn: false
  alias Sportpal.Repo

  alias Sportpal.Offers.Offer

  @doc """
  Retrieves an offer by its ID from the database.

  ## Examples

      iex> get_offer(1)
      %Offer{
        id: 1,
        date: ~D[2022-01-01],
        creator_user_id: 1,
        location_id: 1,
        sport_id: 1
      }

      iex> get_offer(9999)
      nil

  """
  def get_offer(id) do
    Repo.get(Offer, id)
  end

  @doc """
  Retrieves an offer by its ID and preloads its asscoiations from the database.

  ## Examples

      iex> get_offer(1)
      %Offer{
        id: 1,
        date: ~D[2022-01-01],
        creator_user_id: 1,
        creator_user: %Sportpal.Users.User{...},
        location_id: 1,
        location: %Sportpal.Locations.Location{...}
        sport_id: 1
        sport: %Sportpal.Sports.Sport{...},
      }

      iex> get_offer(9999)
      nil

  """
  def get_preloaded_offer(id) do
    Offer
    |> Repo.get(id)
    |> Repo.preload([:creator_user, :sport, :location])
  end

  @doc """
  Fetches all offers after a specific date from a specific city and country.

  ## Examples

      iex> get_all_offers_after_date(%{date: ~D[2022-01-01], city: "New York", country: "USA"})
      [%Sportpal.Offers.Offer{...}, ...]

      iex> get_all_offers_after_date(%{date: ~D[2022-01-01], city: "London", country: "UK"})
      []

  ## Returns

  - A list of `Offer` structs, each preloaded with its associated `:creator_user`, `:sport`, and `:location`.
  [
    %Sportpal.Offers.Offer{
      __meta__: ...,
      id: 1990,
      date: ~D[2024-07-02],
      creator_user_id: 1414,
      creator_user: #Sportpal.Accounts.User<
        __meta__: ...,
        id: 1414,
        email: ...,
        ...
      >,
      sport_id: 1606,
      sport: %Sportpal.Sports.Sport{
        __meta__: ...
        id: 1606,
        name: "tennis",
        skill_level: ...
        ...
      },
      location_id: 1094,
      location: %Sportpal.Locations.Location{
        __meta__: ...
        id: 1094,
        city: "Berlin",
        ...
    },
    ...
  ]
  """
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

  @doc """
  Creates a new offer with the specified parameters.

  ## Examples

      iex> create_offer(%{date: ~D[2022-01-01], creator_user_id: 1, sport_id: 1, location_id: 1})
      {:ok, %Offer{}}

      iex> create_offer(%{date: ~D[2022-01-01], creator_user_id: 2, sport_id: 2, location_id: 2})
      {:error, %Ecto.Changeset{}}

  """
  def create_offer(%{
        date: date,
        creator_user_id: creator_user_id,
        sport_id: sport_id,
        location_id: location_id
      }) do
    %Offer{
      date: date,
      creator_user_id: creator_user_id,
      sport_id: sport_id,
      location_id: location_id
    }
    |> Repo.insert()
    |> case do
      {:ok, offer} ->
        offer
        |> Repo.preload([:creator_user, :sport, :location])

      error ->
        error
    end
  end

  def edit_offer(%{
        id: id,
        date: date,
        creator_user_id: creator_user_id,
        location_id: location_id,
        sport_id: sport_id
      }) do
    # Step 1: Retrieve the offer using a safer approach to handle possible nil returns
    case get_offer(id) do
      nil ->
        {:error, "No offer found or access denied"}

      offer ->
        # Step 2: Using a changeset to properly handle and validate data updates
        changes = %{date: date, location_id: location_id, sport_id: sport_id}
        changeset = Offer.changeset(offer, changes)

        # Step 3: Handle update operation with a case analysis
        case Repo.update(changeset) do
          {:ok, updated_offer} ->
            updated_offer = Repo.preload(updated_offer, [:creator_user, :sport, :location])
            {:ok, updated_offer}

          {:error, changeset} ->
            {:error, changeset}
        end
    end
  end
end
