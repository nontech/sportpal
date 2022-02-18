defmodule SportpalWeb.OnboardingController do
    use Sportpal, :controller

    alias Sportpal.Accounts


    def edit(conn, _params) do
        render(conn, "edit.html")
    end
end