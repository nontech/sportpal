defmodule SportpalWeb.Graphql.SchemaTest do
  use SportpalWeb.ConnCase
  import Sportpal.Factory

  describe "users" do
    @user_query """
    query getUser($id: ID!) {
      user(id: $id) {
        full_name
        username
        email
        location {
          city
          country
        }
      }
    }
    """

    test "query: user", %{conn: conn} do
      # insert a user in test db
      user = insert(:user)

      # make a query
      conn =
        post(conn, "/api/graphql", %{
          "query" => @user_query,
          "variables" => %{id: user.id}
        })

      # get the response
      resp =
        conn
        |> json_response(200)

      # assert
      assert resp = %{
               "data" => %{
                 "user" => %{
                   "email" => user.email,
                   "full_name" => user.full_name,
                   "location" => %{
                     "city" => user.location.city,
                     "country" => user.location.country
                   },
                   "username" => user.username
                 }
               }
             }
    end
  end

  describe "offers" do
    @offers_after_date_query """
    query allOffers($date: Date!, $city: String!, $country: String!) {
      offersAfterDate(date: $date, city: $city, country: $country) {
        date
        creatorUser {
          full_name
        }
        sport {
          name
          skill_level
        }
        location {
          city
          country
        }
      }
    }
    """

    test "query: all offers", %{conn: conn} do
      # all users are located in Berlin
      location =
        insert(:location, %{
          city: "Berlin",
          state: "Berlin",
          zip_code: "10115",
          country: "Germany"
        })

      # logged in user
      insert(:user, %{location: location})

      # other users
      user_2 = insert(:user, %{location: location})
      user_3 = insert(:user, %{location: location})

      # all like to play tennis
      sport_2 = insert(:sport, %{name: "tennis"})
      sport_3 = insert(:sport, %{name: "tennis"})

      # other users put their offers
      offer_2 =
        insert(:offer, %{
          creator_user_id: user_2.id,
          sport_id: sport_2.id,
          location_id: location.id
        })

      offer_3 =
        insert(:offer, %{
          creator_user_id: user_3.id,
          sport_id: sport_3.id,
          location_id: location.id
        })

      # logged in user searches for offers after today
      date = Date.utc_today() |> Date.to_string()

      variables = %{
        date: date,
        city: location.city,
        country: location.country
      }

      # make the query
      conn =
        post(conn, "/api/graphql", %{
          "query" => @offers_after_date_query,
          "variables" => variables
        })

      # get the response
      resp =
        conn
        |> json_response(200)

      actual_response = resp["data"]["offersAfterDate"]

      expected_data = [
        %{
          "creatorUser" => %{"full_name" => user_2.full_name},
          "date" => offer_2.date |> Date.to_string(),
          "location" => %{"city" => location.city, "country" => location.country},
          "sport" => %{"name" => sport_2.name, "skill_level" => sport_2.skill_level}
        },
        %{
          "creatorUser" => %{"full_name" => user_3.full_name},
          "date" => offer_3.date |> Date.to_string(),
          "location" => %{"city" => location.city, "country" => location.country},
          "sport" => %{"name" => sport_3.name, "skill_level" => sport_3.skill_level}
        }
      ]

      # assert
      assert Enum.sort(actual_response) == Enum.sort(expected_data)
    end

    @create_offer_mutation """
      mutation CreateOffer($input: CreateOfferInput!) {
        createOffer(input: $input) {
          id
          date
          creatorUser{
            id
            full_name
          }
          sport {
            id
            name
            skill_level
          }
          location {
            id
            city
            country
          }
        }
      }
    """

    test "create an offer", %{conn: conn} do
      # Setup
      creator_user = insert(:user)
      sport = insert(:sport)
      location = insert(:location)
      date = ~D[2022-01-01] |> Date.to_string()

      variables = %{
        "input" => %{
          "date" => date,
          "creatorUserId" => creator_user.id,
          "sportId" => sport.id,
          "locationId" => location.id
        }
      }

      # make a query
      conn =
        post(conn, "/api/graphql", %{
          "query" => @create_offer_mutation,
          "variables" => variables
        })

      # get the response
      resp =
        conn
        |> json_response(200)

      # expected response
      expected_response = %{
        "data" => %{
          "createOffer" => %{
            "date" => date,
            "creatorUser" => %{
              "id" => creator_user.id,
              "full_name" => creator_user.full_name
            },
            "sport" => %{
              "id" => sport.id,
              "name" => sport.name,
              "skill_level" => sport.skill_level
            },
            "location" => %{
              "id" => location.id,
              "city" => location.city,
              "country" => location.country
            }
          }
        }
      }

      # Assert
      assert resp = expected_response
    end
  end
end
