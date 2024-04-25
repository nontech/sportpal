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

      resolve(&list_all_offers_after_date/3)
    end

    # field :profile_matches, list_of(:match) do
    #   arg(:match, non_null(:profile_match_data))

    #   resolve(&get_profile_matches/3)
    # end
  end

  # MUTATIONS
  # ---------------------------------------

  mutation do
    field :create_offer, :offer do
      arg(:input, non_null(:create_offer_input))
      resolve(&create_offer/3)
    end
  end

  # RESOLVERS
  # ---------------------------------------
  defp get_user(_parent, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  def list_all_offers_after_date(
        _parent,
        %{date: _date, city: _city, country: _country} = args,
        _resolution
      ) do
    {:ok, Offers.get_all_offers_after_date(args)}
  end

  def create_offer(_parent, %{input: input}, _) do
    {:ok, Offers.create_offer(input)}
  end

  # OBJECTS
  # ---------------------------------------

  @desc "A user"
  object :user do
    field :id, :integer
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
    field :id, :integer
    field :city, :string
    field :state, :string
    field :zip_code, :integer
    field :country, :string
  end

  @desc "A sport"
  object :sport do
    field :id, :integer
    field :name, :string
    field :skill_level, :integer
  end

  @desc "An offer"
  object :offer do
    field :id, :integer
    field :date, :date
    field :creator_user, :user
    field :sport, :sport
    field :location, :location
  end

  # INPUT OBJECTS
  # ---------------------------------------

  # @desc "User inputs to create an offer"
  input_object :create_offer_input do
    field :creator_user_id, non_null(:integer)
    field :date, non_null(:date)
    field :sport_id, non_null(:integer)
    field :location_id, non_null(:integer)
  end
end
