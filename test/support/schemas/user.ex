defmodule Seeker.Schemas.User do
  @moduledoc false

  use Ecto.Schema

  alias Seeker.Schemas.Post

  schema "users" do
    field(:name, :string)
    field(:email, :string)

    timestamps()

    has_many(:posts, Post, foreign_key: :author_id)
  end
end
