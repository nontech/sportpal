defmodule SportpalWeb.GoogleAuthController do
    use SportpalWeb, :controller
    plug Ueberauth

    def callback(conn, params) do
        IO.puts "+++"
        IO.inspect(conn.assigns)
    end

    def request(conn, params) do

    end
end