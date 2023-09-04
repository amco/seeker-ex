defmodule Seeker.Search do
  @moduledoc """
  Search implementation for `Seeker`.
  """

  alias Seeker.{Query, Sort}

  def call(scope, params \\ %{}) do
    scope
    |> Query.call(query_params(params))
    |> Sort.call(sort_params(params))
  end

  defp query_params(%{"q" => params}), do: params
  defp query_params(%{q: params}), do: params
  defp query_params(_params), do: %{}

  defp sort_params(%{"s" => params}), do: params
  defp sort_params(%{s: params}), do: params
  defp sort_params(_params), do: ""
end
