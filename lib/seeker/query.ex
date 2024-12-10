defmodule Seeker.Query do
  @moduledoc """
  Query implementation for `Seeker`.
  """

  alias Seeker.Query.Predicates
  alias Seeker.PredicateNotFoundError

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
    with {:ok, key} <- sanitize_key(key),
         {:ok, predicate} <- extract_predicate(key),
         {:ok, subject} <- extract_subject(key, predicate) do
      {String.to_existing_atom(subject), predicate}
    else
      {:error, :predicate_not_found} ->
        raise PredicateNotFoundError, key: key
    end
  end

  defp sanitize_key(key) do
    {:ok, to_string(key)}
  end

  defp extract_predicate(key) do
    case Enum.find(@predicates, &String.ends_with?(key, "_#{&1}")) do
      nil -> {:error, :predicate_not_found}
      predicate -> {:ok, predicate}
    end
  end

  defp extract_subject(key, predicate) do
    {:ok, String.replace_suffix(key, "_#{predicate}", "")}
  end
end
