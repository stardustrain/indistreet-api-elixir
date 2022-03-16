defmodule IndistreetApi.Repo do
  use Ecto.Repo,
    otp_app: :indistreet_api,
    adapter: Ecto.Adapters.SQLite3
end
