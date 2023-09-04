defmodule Seeker.Integration.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :seeker,
    adapter: Ecto.Adapters.Postgres
end
