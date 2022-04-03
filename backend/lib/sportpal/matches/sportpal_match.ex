defmodule Sportpal.Matches.Sportpal_Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sportpal_matches" do
    timestamps()
  end

  @doc false
  def changeset(sportpal_match, attrs) do
    sportpal_match
    |> cast(attrs, [])
    |> validate_required([])
  end
end
