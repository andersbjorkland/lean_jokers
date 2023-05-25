defmodule LeanJokers.Repo do
  use Ecto.Repo,
    otp_app: :lean_jokers,
    adapter: Ecto.Adapters.Postgres
end
