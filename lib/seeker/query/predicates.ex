defmodule Seeker.Query.Predicates do
  @moduledoc """
  Query predicates implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  def call(scope, {_column, _predicate}, ""), do: scope

  def call(scope, {column, :eq}, value) do
    scope |> where([scope], field(scope, ^column) == ^value)
  end

  def call(scope, {column, :not_eq}, value) do
    scope |> where([scope], field(scope, ^column) != ^value)
  end

  def call(scope, {column, :in}, value) do
    scope |> where([scope], field(scope, ^column) in ^value)
  end

  def call(scope, {column, :not_in}, value) do
    scope |> where([scope], field(scope, ^column) not in ^value)
  end

  def call(scope, {column, :cont}, value) do
    scope |> where([scope], like(field(scope, ^column), ^"%#{value}%"))
  end

  def call(scope, {column, :not_cont}, value) do
    scope |> where([scope], not like(field(scope, ^column), ^"%#{value}%"))
  end

  def call(scope, {column, :i_cont}, value) do
    scope |> where([scope], ilike(field(scope, ^column), ^"%#{value}%"))
  end

  def call(scope, {column, :not_i_cont}, value) do
    scope |> where([scope], not ilike(field(scope, ^column), ^"%#{value}%"))
  end

  def call(scope, {column, :start}, value) do
    scope |> where([scope], like(field(scope, ^column), ^"#{value}%"))
  end

  def call(scope, {column, :not_start}, value) do
    scope |> where([scope], not like(field(scope, ^column), ^"#{value}%"))
  end

  def call(scope, {column, :end}, value) do
    scope |> where([scope], like(field(scope, ^column), ^"%#{value}"))
  end

  def call(scope, {column, :not_end}, value) do
    scope |> where([scope], not like(field(scope, ^column), ^"%#{value}"))
  end

  def call(scope, {column, :gt}, value) do
    scope |> where([scope], field(scope, ^column) > ^value)
  end

  def call(scope, {column, :gteq}, value) do
    scope |> where([scope], field(scope, ^column) >= ^value)
  end

  def call(scope, {column, :lt}, value) do
    scope |> where([scope], field(scope, ^column) < ^value)
  end

  def call(scope, {column, :lteq}, value) do
    scope |> where([scope], field(scope, ^column) <= ^value)
  end
end
