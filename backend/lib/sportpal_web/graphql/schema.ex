defmodule SportpalWeb.Graphql.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  alias Sportpal.Accounts
  alias Sportpal.Inquiries.Inquiries

  # QUERIES
  # ---------------------------------------

  query do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&get_user/3)
    end

    field :instant_matches, list_of(:match) do
      arg(:match, non_null(:instant_match_data))

      resolve(&get_instant_matches/3)
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

  defp get_instant_matches(_parent, %{match: match_args} = _args, _resolution) do
    inquiries = Inquiries.get_matches(match_args)

    # convert it into desired object shape
    result =
      Enum.reduce(inquiries, [], fn i, acc ->
        res = %{
          full_name: i.user.full_name,
          profile_pic: i.user.profile_pic,
          sport: i.sport,
          preferred_skill_level: i.preferred_skill_level,
          city: i.city,
          country: i.country
        }

        [res | acc]
      end)
      |> Enum.reverse()

    {:ok, result}
  end

  # OBJECTS
  # ---------------------------------------

  @desc "A user"
  object :user do
    field :email, :string
    field :confirmed_at, :naive_datetime
    field :username, :string
    field :gender, :string
    field :bio, :string
    field :sports, list_of(:string)
    field :date_of_birth, :date
    field :full_name, :string
    field :profile_pic, :string
    field :city, :string
    field :country, :string
    field :availability, :string
    field :matching_partners, list_of(:string)
  end

  @desc "A matching sportpal"
  object :match do
    field :sports, list_of(:string)
    # field(:date, non_null(:date))
    field :city, non_null(:string)
    field :country, non_null(:string)
    field :skill_level, non_null(:string)
    field :user, :matching_sportpal
  end

  @desc "A matching sportpal user details"
  object :matching_sportpal do
    field :username, :string
    field :full_name, :string
    field :profile_pic, :string
    field :bio, :string
  end

  # INPUT OBJECTS
  # ---------------------------------------

  # merely here to model structure
  # does not have any args or a resolver of its own
  @desc "User inputs for instant match"
  input_object :instant_match_data do
    field :city, non_null(:string)
    field :country, non_null(:string)
    field :sports, list_of(:string)
    # TODO: fix date type
    # field(:date, non_null(:date))
    field :skill_level, non_null(:string)
  end
end
