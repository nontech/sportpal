defmodule SportpalWeb.OnboardingController do
    use SportpalWeb, :controller

    alias Sportpal.Accounts


    def edit(conn, _params) do
        changeset = Accounts.change_user_onboarding_data(conn.assigns.current_user)
        render(conn, "edit.html", changeset: changeset)
    end

    def update(conn, %{"user" => user_params}) do
        user = conn.assigns.current_user
    
        case Accounts.update_user_onboarding_data(user, user_params) do
          {:ok, user} ->
            conn
            |> put_flash(:info, "Successfully Saved")
            |> redirect(to: Routes.onboarding_path(conn, :edit))
    
          {:error, changeset} ->
            render(conn, "edit.html", changeset: changeset)
        end
    end

end