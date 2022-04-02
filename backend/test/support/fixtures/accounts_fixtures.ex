defmodule Sportpal.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sportpal.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  # onboarding data
  def valid_username, do: "user#{System.unique_integer()}"
  def valid_gender, do: "Male"
  def valid_country, do: "Germany"
  def valid_city, do: "Berlin"
  def valid_date_of_birth, do:  "1998-02-05"
  def valid_bio, do: "testing.."
  def valid_sports, do: ["Tennis"]

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def valid_onboarding_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      username: valid_username(),
      gender: valid_gender(),
      country: valid_country(),
      city: valid_city(),
      date_of_birth: valid_date_of_birth(),
      bio: valid_bio(),
      sports: valid_sports()
    })
  end


  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Sportpal.Accounts.register_user()

    user
  end

  def user_fixture_with_onboarding(attrs \\ %{}) do
    user = user_fixture()
    {:ok, user} = Sportpal.Accounts.update_user_onboarding_data(user, valid_onboarding_attributes())

    user

  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
