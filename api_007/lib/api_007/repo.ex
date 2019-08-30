defmodule Api007.Repo do
  use Ecto.Repo,
    otp_app: :api_007,
    adapter: Ecto.Adapters.Postgres
end
