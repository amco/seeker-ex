defmodule Seeker.Schemas.Category do
  @moduledoc false

  use Ecto.Schema

  alias Seeker.Schemas.Post

  schema "categories" do
    field :name, :string

    timestamps()

    has_many :posts, Post
  end
end
