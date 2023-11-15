defmodule Sportpal.Repo do
  use Ecto.Repo,
    otp_app: :sportpal,
    adapter: Ecto.Adapters.Postgres
end
