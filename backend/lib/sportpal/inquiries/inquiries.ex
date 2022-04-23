defmodule Sportpal.Inquiries.Inquiries do
  import Ecto.Query
  alias Sportpal.Repo
  alias Sportpal.Inquiries.Inquiry
  alias Sportpal.Accounts.User

  def get_all() do
    Inquiry
    |> Repo.all()
  end

  def get_matches(
        %{
          user_id: user_id,
          city: city,
          country: country,
          sport: sport,
          # date: date,
          preferred_skill_level: preferred_skill_level
        } = _args
      ) do
    base_query = from(i in Inquiry)

    base_query
    |> where(
      [i],
      # make sure it is not his own entry
      # i.date == ^date and
      i.user_id != ^user_id and
        i.city == ^city and
        i.country == ^country and
        i.sport == ^sport and
        i.preferred_skill_level == ^preferred_skill_level
    )
    |> join(:left, [i], u in User, on: i.user_id == u.id)
    |> select([i, u], u)
    |> Repo.all()
  end
end
