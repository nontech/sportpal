defmodule Sportpal.Sports.Sport do
  use Ecto.Schema

  schema "sports" do
    field :name, :string
    field :skill_level, :integer

    timestamps()
  end
end
