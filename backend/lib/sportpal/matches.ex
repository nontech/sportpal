defmodule Sportpal.Matches do
  import Ecto.Query, warn: false
  alias Sportpal.Repo

  alias Sportpal.Accounts
  alias Sportpal.Accounts.User

  def list_matches(user) do
    User
    |> where([u], fragment("? && ?", u.sports, ^user.sports))
    |> Repo.all()
  end
end
