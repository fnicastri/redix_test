defmodule RedixTest.Repo do
  use Ecto.Repo,
    otp_app: :redix_test,
    adapter: Ecto.Adapters.Postgres
end
