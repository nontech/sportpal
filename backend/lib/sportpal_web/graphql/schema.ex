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

    field :exact_matches, list_of(:user) do
      arg(:match, non_null(:exact_match_form))

      resolve(&get_exact_matches/3)
    end
  end

  # MUTATIONS
  # ---------------------------------------

  # RESOLVERS
  # ---------------------------------------
  defp get_user(_parent, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  defp get_exact_matches(_parent, %{match: match_args} = _args, _resolution) do
    {:ok, Inquiries.get_matches(match_args)}
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

  # INPUT OBJECTS
  # ---------------------------------------

  # merely here to model structure
  # does not have any args or a resolver of its own
  @desc "User inputs for exact match"
  input_object :exact_match_form do
    field(:user_id, non_null(:integer))
    field(:city, non_null(:string))
    field(:country, non_null(:string))
    field(:sport, non_null(:string))
    # field(:date, non_null(:date))
    field(:preferred_skill_level, non_null(:string))
  end
end
