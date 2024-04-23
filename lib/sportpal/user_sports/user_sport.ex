defmodule Sportpal.UserSports.UserSport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_sports" do
    # one-to-one
    belongs_to :user, Sportpal.Accounts.User
    belongs_to :sport, Sportpal.Sports.Sport

    timestamps()
  end
end
