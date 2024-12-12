defmodule Seeker.Joins do
  @moduledoc """
  Joins implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  alias Seeker.{Query, Sort, Extractor}

  @doc """
  Adds joins statements to the ecto query based on
  the query(`q`) and sort(`s`) params.

  ## Parameters

    - scope: Ecto.Query [Ecto query struct]
    - params: Map [Plug.Conn params]

  ## Examples

      iex> call(scope, params)
      %Ecto.Query{}

  """
  @spec call(Ecto.Query.t(), map()) :: Ecto.Query.t()
  def call(scope, params) do
    query_assocs =
      params
      |> Query.params()
      |> query_associations()
      |> MapSet.new()

    sort_assocs =
      params
      |> Sort.params()
      |> sort_associations()
      |> MapSet.new()

    query_assocs
    |> MapSet.union(sort_assocs)
    |> Enum.reduce(scope, &join_association/2)
  end

  defp join_association(name, scope) do
    join(scope, :inner, [root], x in assoc(root, ^name), as: ^name)
  end

  defp query_associations(filters) do
    filters
    |> Map.keys()
    |> Enum.map(&to_string/1)
    |> Enum.map(&Extractor.association!/1)
    |> Enum.reject(&(&1 == :root))
  end

  defp sort_associations(sorts) do
    sorts
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "+"))
    |> Enum.map(&List.first/1)
    |> Enum.map(&Extractor.association!/1)
    |> Enum.reject(&(&1 == :root))
  end
end
