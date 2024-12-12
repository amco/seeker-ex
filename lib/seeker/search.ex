defmodule Seeker.Search do
  @moduledoc """
  Search implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  alias Seeker.{Joins, Query, Sort}

  @doc """
  Adds filter and order statements to the ecto query based on
  the query(`q`) and sort(`s`) params.

  ## Parameters

    - scope: Ecto.Query [Ecto query struct]
    - params: Map [Plug.Conn params]

  ## Examples

      iex> call(scope, params)
      %Ecto.Query{}

  """
  @spec call(Ecto.Query.t(), map()) :: Ecto.Query.t()
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
