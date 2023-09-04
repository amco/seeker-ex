defmodule Seeker.Query do
  @moduledoc """
  Query implementation for `Seeker`.
  """

  alias Seeker.Query.Predicates

  @predicates [
    :not_eq,
    :eq,
    :not_in,
    :in,
    :not_i_cont,
    :i_cont,
    :not_cont,
    :cont,
    :not_start,
    :start,
    :not_end,
    :end,
    :gt,
    :gteq,
    :lt,
    :lteq
  ]

  def call(scope, filters) do
    Enum.reduce(filters, scope, fn {key, value}, scope ->
      Predicates.call(scope, extract_data_from_key(key), value)
    end)
  end

  defp extract_data_from_key(key) do
    key = to_string(key)
    predicate = extract_predicate(key)
    {extract_column(key, predicate), predicate}
  end

  defp extract_predicate(key) do
    Enum.find(@predicates, &String.ends_with?(key, "_#{&1}"))
  end

  defp extract_column(key, predicate) do
    String.replace_suffix(key, "_#{predicate}", "") |> String.to_atom()
  end
end
