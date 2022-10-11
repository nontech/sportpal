defmodule Sportpal.Inquiries.Inquiries do
  @moduledoc """
  The Inquiries context.
  """

  import Ecto.Query, warn: false
  alias Sportpal.Repo
  alias Sportpal.Inquiries.Inquiry

  @doc """
  Returns the list of Inquiries with preloaded user data.

  ## Examples

      iex> matches()
      [%Inquiry{}, ...]

  """
  def matches(
        %{
          user_id: user_id,
          city: city,
          country: country,
          sport: sport,
          # date: date,
          preferred_skill_level: preferred_skill_level
        } = _args
      ) do
    # find the inquiry
    matching_inquiry =
      from i in Inquiry,
        # TODO: Fix-the date type do not match
        # i.date == ^date and
        # make sure it is not his own entry
        where:
          i.user_id != ^user_id and
            i.city == ^city and
            i.country == ^country and
            i.sport == ^sport and
            i.preferred_skill_level == ^preferred_skill_level

    # preload associated user
    query =
      from i in matching_inquiry,
        # To avoid a separate query for preload
        # See- https://hexdocs.pm/ecto/Ecto.Query.html#preload/3
        join: u in assoc(i, :user),
        preload: [user: u]

    Repo.all(query)
  end

  @doc """
  Returns the list of inquiries.

  ## Examples

      iex> list_inquiries()
      [%Inquiry{}, ...]

  """
  def list_inquiries do
    raise "TODO"
  end

  @doc """
  Gets a single inquiry.

  Raises if the Inquiry does not exist.

  ## Examples

      iex> get_inquiry!(123)
      %Inquiry{}

  """
  def get_inquiry!(id), do: raise("TODO")

  @doc """
  Creates a inquiry.

  ## Examples

      iex> create_inquiry(%{field: value})
      {:ok, %Inquiry{}}

      iex> create_inquiry(%{field: bad_value})
      {:error, ...}

  """
  def create_inquiry(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a inquiry.

  ## Examples

      iex> update_inquiry(inquiry, %{field: new_value})
      {:ok, %Inquiry{}}

      iex> update_inquiry(inquiry, %{field: bad_value})
      {:error, ...}

  """
  def update_inquiry(%Inquiry{} = inquiry, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Inquiry.

  ## Examples

      iex> delete_inquiry(inquiry)
      {:ok, %Inquiry{}}

      iex> delete_inquiry(inquiry)
      {:error, ...}

  """
  def delete_inquiry(%Inquiry{} = inquiry) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking inquiry changes.

  ## Examples

      iex> change_inquiry(inquiry)
      %Todo{...}

  """
  def change_inquiry(%Inquiry{} = inquiry, _attrs \\ %{}) do
    raise "TODO"
  end
end
