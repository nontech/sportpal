defmodule SportpalWeb.Graphql.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  alias Sportpal.Accounts
  alias Sportpal.Offers.Offers

  # QUERIES
  # ---------------------------------------

  query do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&get_user/3)
    end

    field :offers_after_date, list_of(:offer) do
      arg(:date, non_null(:date))
      arg(:city, non_null(:string))
      arg(:country, non_null(:string))

      resolve(&get_matches_after_date/3)
    end

    # field :profile_matches, list_of(:match) do
    #   arg(:match, non_null(:profile_match_data))

    #   resolve(&get_profile_matches/3)
    # end
  end

  # MUTATIONS
  # ---------------------------------------

  # RESOLVERS
  # ---------------------------------------
  defp get_user(_parent, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  def get_matches_after_date(
        _parent,
        %{date: _date, city: _city, country: _country} = args,
        _resolution
      ) do
    {:ok, Offers.get_all_offers_after_date(args)}
  end

  # OBJECTS
  # ---------------------------------------

  @desc "A user"
  object :user do
    field :email, :string
    field :full_name, :string
    field :username, :string
    field :gender, :string
    field :date_of_birth, :date
    field :profile_pic, :string
    field :location, :location
    field :sports, list_of(:sport)
  end

  @desc "A location"
  object :location do
    field :city, :string
    field :state, :string
    field :zip_code, :integer
    field :country, :string
  end

  @desc "A sport"
  object :sport do
    field :name, :string
    field :skill_level, :integer
  end

  @desc "An offer"
  object :offer do
    field :date, :date
    field :creator_user, :user
    field :sport, :sport
    field :location, :location
  end

  # INPUT OBJECTS
  # ---------------------------------------

  # merely here to model structure
  # does not have any args or a resolver of its own
  # @desc "User inputs for instant match"
  # input_object :instant_match_data do
  #   field :city, non_null(:string)
  #   field :country, non_null(:string)
  #   field :sports, list_of(:string)
  #   # TODO: fix date type
  #   # field(:date, non_null(:date))
  #   field :skill_level, non_null(:string)
  # end
end
