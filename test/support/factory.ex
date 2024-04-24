# with Ecto factories, we can create test data with ease
defmodule Sportpal.Factory do
  use ExMachina.Ecto, repo: Sportpal.Repo

  alias Faker.{Address, Lorem, Person, File, Date}
  alias Sportpal.Accounts.User
  alias Sportpal.Locations.Location
  alias Sportpal.Sports.Sport
  alias Sportpal.UserSports.UserSport
  alias Sportpal.Applications.Application
  alias Sportpal.Offers.Offer

  def user_factory(args \\ %{}) do
    location = Map.get(args, :location, insert(:location))

    %User{
      id: System.unique_integer([:positive]),
      full_name: "#{Person.first_name()} #{Person.last_name()}",
      username: Lorem.word(),
      gender: ["male", "female", "other"] |> Enum.random(),
      date_of_birth: Date.between(~D[1950-01-01], ~D[2003-12-31]),
      email: sequence(:email, &"user#{&1}@mail.com"),
      password: "some_super_secure_pwd",
      profile_pic: File.file_name(:image),
      location_id: location.id,
      # preload location
      location: location
    }
  end

  def location_factory do
    %Location{
      id: System.unique_integer([:positive]),
      city: Address.city(),
      state: Address.state(),
      zip_code: Address.zip_code(),
      country: Address.country()
    }
  end

  def sport_factory do
    %Sport{
      id: System.unique_integer([:positive]),
      name: ["tennis", "cricket", "basketball", "soccer"] |> Enum.random(),
      # Assuming skill levels are 1-5
      skill_level: Enum.random(1..5)
    }
  end

  def user_sports_factory do
    %UserSport{
      id: System.unique_integer([:positive]),
      user_id: build(:user).id,
      sport_id: build(:sport).id
    }
  end

  def application_factory do
    %Application{
      id: System.unique_integer([:positive]),
      applicant_user_id: build(:user).id,
      offer_id: build(:offer).id,
      # Assuming skill levels are 1-5
      skill_level: Enum.random(1..5),
      accepted: [true, false] |> Enum.random()
    }
  end

  def offer_factory do
    # create an offer in future (5 days from today)
    start_date = Date.forward(5)
    end_date = ~D[2024-12-31]

    %Offer{
      id: System.unique_integer([:positive]),
      creator_user_id: build(:user).id,
      sport_id: build(:sport).id,
      location_id: build(:location).id,
      date: Date.between(start_date, end_date)
    }
  end
end
