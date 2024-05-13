defmodule Seeker.Schemas.Post do
  @moduledoc false

  use Ecto.Schema

  alias Seeker.Schemas.{User, Category, Comment}

  schema "posts" do
    field(:title, :string)
    field(:status, :string)
    field(:date, :utc_datetime)

    timestamps()

    belongs_to(:author, User)
    belongs_to(:category, Category)

    has_many(:comments, Comment)
  end
end
