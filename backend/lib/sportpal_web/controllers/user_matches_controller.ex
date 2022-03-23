defmodule SportpalWeb.UserMatchesController do
    use SportpalWeb, :controller
    alias Sportpal.Matches

    def index(conn, _params) do
        matches = Matches.list_matches(conn.assigns.current_user)
        render(conn, "index.html", matches: matches, user: conn.assigns.current_user)
    end


end