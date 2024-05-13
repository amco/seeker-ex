defmodule Seeker.Integration.SeekerApp do
  @moduledoc false

  use Seeker,
    otp_app: :seeker,
    repo: Seeker.Integration.Repo
end
