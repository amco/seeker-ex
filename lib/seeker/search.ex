defmodule Seeker.Search do
  @moduledoc """
  Search implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  alias Seeker.{Joins, Query, Sort}

  def call(scope, params \\ %{}) do
    sorts = Sort.params(params)
    filters = Query.params(params)

    scope
    |> from(as: :root)
    |> Joins.call(params)
    |> Query.call(filters)
    |> Sort.call(sorts)
  end
end
