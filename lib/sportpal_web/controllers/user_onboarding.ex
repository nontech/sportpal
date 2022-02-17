defmodule SportpalWeb.UserOnboarding do
    import Plug.Conn
    import Phoenix.Controller
  
    alias Sportpal.Accounts.User
    alias SportpalWeb.Router.Helpers, as: Routes

    def require_onboarding(conn, _opts) do
        user = Map.from_struct(conn.assigns.current_user)
        required_fields = [:username, :gender, :location, :bio, :date_of_birth, :interests]
        if required_fields |> Enum.all?(fn x -> user[x] !== nil end) do
            conn
            |> redirect(to: Routes.user_session_path(conn, :new))
            |> halt()
        else
            conn
            |> redirect(to: Routes.onboarding_path(conn, :edit))
        end
    end

end