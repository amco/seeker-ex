defmodule Seeker.Schemas.Comment do
  @moduledoc false

  use Ecto.Schema

  alias Seeker.Schemas.Post

  schema "comments" do
    field :body, :string

    timestamps()

    belongs_to :post, Post
  end
end
