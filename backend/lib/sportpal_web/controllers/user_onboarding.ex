defmodule SportpalWeb.UserOnboarding do
  import Plug.Conn
  import Phoenix.Controller

  alias SportpalWeb.Router.Helpers, as: Routes

  def require_onboarding(conn, _opts) do
    user = Map.from_struct(conn.assigns.current_user)
    required_fields = [:username, :gender, :city, :country, :bio, :date_of_birth]

    if required_fields |> Enum.all?(fn x -> user[x] !== nil end) do
      conn
    else
      conn
      |> put_flash(:info, "Please complete your onboarding first")
      |> redirect(to: Routes.onboarding_path(conn, :edit))
      |> halt()
    end
  end
end
