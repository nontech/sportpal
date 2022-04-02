defmodule SportpalWeb.OnboardingControllerTest do
    use SportpalWeb.ConnCase, async: true
    import Sportpal.AccountsFixtures

    setup :register_and_log_in_user

    describe "GET /users/onboarding-basic-info" do
        test "renders onboarding basic info page", %{conn: conn} do
            conn = get(conn, Routes.onboarding_path(conn, :edit))
            response = html_response(conn, 200)
            assert response =~ "<h3>Basic information</h3>"
        end

        test "redirects if user is not logged in" do
            conn = build_conn()
            conn = get(conn, Routes.onboarding_path(conn, :edit))
            assert redirected_to(conn) == Routes.user_session_path(conn, :new)
        end
    end

    describe "GET /users/onboarding-sports" do
        test "renders onboarding sports page", %{conn: conn} do
            conn = get(conn, Routes.onboarding_path(conn, :edit_sports))
            response = html_response(conn, 200)
            assert response =~ "<h3>Select Sports</h3>"
        end

        test "redirects if user is not logged in" do
            conn = build_conn()
            conn = get(conn, Routes.onboarding_path(conn, :edit_sports))
            assert redirected_to(conn) == Routes.user_session_path(conn, :new)
        end
    end

    describe "PUT /users/onboarding-basic-info" do
        test "updates the user onboarding data", %{conn: conn, user: _user} do
            conn =
                put(conn, Routes.onboarding_path(conn, :update), %{
                    "user" => %{
                        username: valid_username(),
                        gender: valid_gender(),
                        country: valid_country(),
                        city: valid_city(),
                        date_of_birth: valid_date_of_birth(),
                        bio: valid_bio()
                    }  
                })

            assert redirected_to(conn) == Routes.onboarding_path(conn, :edit_sports)
            assert get_flash(conn, :info) =~ "Successfully Saved"
        end

    end

    describe "PUT /users/onboarding-sports" do
        test "updates the user sports data", %{conn: conn, user: _user} do
            conn =
                put(conn, Routes.onboarding_path(conn, :update_sports), %{
                    "user" => %{
                        sports: valid_sports()
                    }  
                })
            
            assert redirected_to(conn) == Routes.user_matches_path(conn, :index)
            assert get_flash(conn, :info) =~ "Successfully Saved"
        end
    end


end