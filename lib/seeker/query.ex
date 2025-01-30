defmodule Seeker.Query do
  @moduledoc """
  Query implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  alias Seeker.Extractor
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
    :lteq,
    :btwn
  ]

  @doc """
  Returns the `q` param key in the connection params.
  It tries to find it by using the string or atom key.

  ## Parameters

    - params: Map [Plug Conn params]

  ## Examples

      iex> params(%{"q" => %{"name_eq" => "Foo"}})
      %{"name_eq" => "Foo"}

  """
  @spec params(map()) :: map()
  def params(%{"q" => params}), do: params
  def params(%{q: params}), do: params
  def params(_params), do: %{}

  @doc """
  Adds filters statements to the ecto query based on the `q` param.

  ## Parameters

    - scope: Ecto.Query [Ecto query struct]
    - filters: Map [Query params map]

  ## Examples

      iex> call(scope, filters)
      %Ecto.Query{}

  """
  @spec call(Ecto.Query.t(), map()) :: Ecto.Query.t()
  def call(scope, filters) do
    Enum.reduce(filters, scope, fn {key, value}, scope ->
      Predicates.call(scope, extract_data_from_key(key), value)
    end)
  end

  defp extract_data_from_key(key) do
    with {:ok, key} <- {:ok, to_string(key)},
         {:ok, predicate} <- extract_predicate(key),
         {:ok, subject} <- extract_subject(key, predicate),
         {:ok, association} <- Extractor.association(subject),
         {:ok, column} <- Extractor.column(subject) do
      {association, column, predicate}
    else
      {:error, :predicate_not_found} ->
        raise PredicateNotFoundError, key: key
    end
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
