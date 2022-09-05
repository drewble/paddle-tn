defmodule Drywell.Repo do
  use Ecto.Repo,
    otp_app: :drywell,
    adapter: Ecto.Adapters.Postgres
end
