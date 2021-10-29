defmodule Paddletn.Repo do
  use Ecto.Repo,
    otp_app: :paddletn,
    adapter: Ecto.Adapters.Postgres
end
