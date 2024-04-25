defmodule Sportpal.Sports.Sports do
  alias Sportpal.Repo
  alias Sportpal.Sports.Sport

  @doc """
  Fetches all sports from the database.

  ## Examples

      iex> Sportpal.Sports.Sports.list_sports()
      [%Sport{name: "Tennis", skill_level: 0}, %Sport{name: "Badminton", skill_level: 1}, ...]

      iex> Sportpal.Sports.Sports.list_sports()
      []

  """
  def list_sports do
    Repo.all(Sport)
  end

  @doc """
  Fetches a sport by its ID.

  ## Parameters

  - `id`: The ID of the sport.

  ## Examples

    iex> Sportpal.Sports.Sports.get_sport!(1)
    %Sport{id: 1, name: "Tennis", skill_level: 0}

    iex> Sportpal.Sports.Sports.get_sport!(2)
    ** (Ecto.NoResultsError)

  """
  def get_sport!(id), do: Repo.get!(Sport, id)

  @doc """
  Creates a new sport.

  ## Parameters

  - `name`: The name of the sport.
  - `skill_level`: The skill level of the sport. An integer between 0 and 2.
      O represents 'beginner', 1 represents 'intermediate', and 2 represents 'advanced'.

  ## Examples

      iex> Sportpal.Sports.Sports.create_sport("Basketball", "Intermediate")
      {:ok, %Sport{name: "Tennis", skill_level: 0}}

      iex> Sportpal.Sports.Sports.create_sport("Badminton", -1)
      {:error, changeset}

  """
  def create_sport(name, skill_level) do
    %Sport{}
    |> Sport.changeset(%{name: name, skill_level: skill_level})
    |> Repo.insert()
  end

  @doc """
  Deletes a sport by its ID.

  ## Parameters

  - `id`: The ID of the sport.

  ## Examples

      iex> Sportpal.Sports.Sports.delete_sport(1)
      {:ok, %Sport{}}

      iex> Sportpal.Sports.Sports.delete_sport(2)
      ** (Ecto.NoResultsError)

  """
  def delete_sport(id) do
    sport = get_sport!(id)
    Repo.delete(sport)
  end
end
