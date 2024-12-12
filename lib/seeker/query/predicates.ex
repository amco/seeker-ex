defmodule Seeker.Query.Predicates do
  @moduledoc """
  Query predicates implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  def call(scope, {_binding, _column, _predicate}, ""), do: scope

  def call(scope, {binding, column, :eq}, value) do
    scope |> where([{^binding, table}], field(table, ^column) == ^value)
  end

  def call(scope, {binding, column, :not_eq}, value) do
    scope |> where([{^binding, table}], field(table, ^column) != ^value)
  end

  def call(scope, {binding, column, :in}, value) do
    scope |> where([{^binding, table}], field(table, ^column) in ^value)
  end

  def call(scope, {binding, column, :not_in}, value) do
    scope |> where([{^binding, table}], field(table, ^column) not in ^value)
  end

  def call(scope, {binding, column, :cont}, value) do
    scope |> where([{^binding, table}], like(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {binding, column, :not_cont}, value) do
    scope |> where([{^binding, table}], not like(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {binding, column, :i_cont}, value) do
    scope |> where([{^binding, table}], ilike(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {binding, column, :not_i_cont}, value) do
    scope |> where([{^binding, table}], not ilike(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {binding, column, :start}, value) do
    scope |> where([{^binding, table}], like(field(table, ^column), ^"#{value}%"))
  end

  def call(scope, {binding, column, :not_start}, value) do
    scope |> where([{^binding, table}], not like(field(table, ^column), ^"#{value}%"))
  end

  def call(scope, {binding, column, :end}, value) do
    scope |> where([{^binding, table}], like(field(table, ^column), ^"%#{value}"))
  end

  def call(scope, {binding, column, :not_end}, value) do
    scope |> where([{^binding, table}], not like(field(table, ^column), ^"%#{value}"))
  end

  def call(scope, {binding, column, :gt}, value) do
    scope |> where([{^binding, table}], field(table, ^column) > ^value)
  end

  def call(scope, {binding, column, :gteq}, value) do
    scope |> where([{^binding, table}], field(table, ^column) >= ^value)
  end

  def call(scope, {binding, column, :lt}, value) do
    scope |> where([{^binding, table}], field(table, ^column) < ^value)
  end

  def call(scope, {binding, column, :lteq}, value) do
    scope |> where([{^binding, table}], field(table, ^column) <= ^value)
  end
end
