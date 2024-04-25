defmodule Sportpal.Locations.Locations do
  alias Sportpal.Repo
  alias Sportpal.Locations.Location

  @doc """
  Fetches all locations from the database.

  ## Examples

      iex> Sportpal.Locations.Locations.list_locations()
      [%Location{city: "San Francisco", state: "CA", zip_code: 94111, country: "USA"}, %Location{city: "New York", state: "NY", zip_code: 10001, country: "USA"}, ...]

      iex> Sportpal.Locations.Locations.list_locations()
      []

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Fetches a location by its ID.

  ## Parameters

  - `id`: The ID of the location.

  ## Examples

      iex> Sportpal.Locations.Locations.get_location!(1)
      %Location{id: 1, city: "San Francisco", state: "CA", zip_code: 94111, country: "USA"}

      iex> Sportpal.Locations.Locations.get_location!(2)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a new location.

  ## Parameters

  - `city`: The city of the new location.
  - `state`: The state of the new location.
  - `zip_code`: The postal code of the new location.
  - `country`: The country of the new location.

  ## Examples

      iex> Sportpal.Locations.Locations.create_location("Los Angeles", "CA", 90001, "USA")
      {:ok, %Location{city: "Los Angeles", state: "CA", zip_code: 90001, country: "USA"}}

      iex> Sportpal.Locations.Locations.create_location("Invalid City", "", -1, "")
      {:error, changeset}

  """
  def create_location(city, state, zip_code, country) do
    %Location{}
    |> Location.changeset(%{city: city, state: state, zip_code: zip_code, country: country})
    |> Repo.insert()
  end

  @doc """
  Deletes a location by its ID.

  ## Parameters

  - `id`: The ID of the location.

  ## Examples

      iex> Sportpal.Locations.Locations.delete_location(1)
      {:ok, %Location{}}

      iex> Sportpal.Locations.Locations.delete_location(999)
      ** (Ecto.NoResultsError)

  """
  def delete_location(id) do
    location = get_location!(id)
    Repo.delete(location)
  end
end
