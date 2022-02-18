defmodule SportpalWeb.OnboardingController do
    use SportpalWeb, :controller

    alias Sportpal.Accounts


    def edit(conn, _params) do
        changeset = Accounts.change_user_onboarding_data(conn.assigns.current_user)
        render(conn, "edit.html", changeset: changeset)
    end

end