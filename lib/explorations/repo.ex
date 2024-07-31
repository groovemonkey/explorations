defmodule Explorations.Repo do
  use Ecto.Repo,
    otp_app: :explorations,
    adapter: Ecto.Adapters.Postgres
end
