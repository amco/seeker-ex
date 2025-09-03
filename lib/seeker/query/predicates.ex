defmodule Seeker.Query.Predicates do
  @moduledoc """
  Query predicates implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  def call(scope, {association, column, :present}, _value) do
    scope |> where([{^association, table}], field(table, ^column) != "")
  end

  def call(scope, {association, column, :blank}, _value) do
    scope |> where([{^association, table}], field(table, ^column) == "")
  end

  def call(scope, {association, column, :is_nil}, _value) do
    scope |> where([{^association, table}], is_nil(field(table, ^column)))
  end

  def call(scope, {association, column, :is_not_nil}, _value) do
    scope |> where([{^association, table}], not is_nil(field(table, ^column)))
  end

  def call(scope, {_association, _column, _predicate}, ""), do: scope

  def call(scope, {association, column, :eq}, value) do
    scope |> where([{^association, table}], field(table, ^column) == ^value)
  end

  def call(scope, {association, column, :not_eq}, value) do
    scope |> where([{^association, table}], field(table, ^column) != ^value)
  end

  def call(scope, {association, column, :in}, value) do
    scope |> where([{^association, table}], field(table, ^column) in ^value)
  end

  def call(scope, {association, column, :not_in}, value) do
    scope |> where([{^association, table}], field(table, ^column) not in ^value)
  end

  def call(scope, {association, column, :cont}, value) do
    scope |> where([{^association, table}], like(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {association, column, :not_cont}, value) do
    scope |> where([{^association, table}], not like(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {association, column, :i_cont}, value) do
    scope |> where([{^association, table}], ilike(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {association, column, :not_i_cont}, value) do
    scope |> where([{^association, table}], not ilike(field(table, ^column), ^"%#{value}%"))
  end

  def call(scope, {association, column, :start}, value) do
    scope |> where([{^association, table}], like(field(table, ^column), ^"#{value}%"))
  end

  def call(scope, {association, column, :not_start}, value) do
    scope |> where([{^association, table}], not like(field(table, ^column), ^"#{value}%"))
  end

  def call(scope, {association, column, :end}, value) do
    scope |> where([{^association, table}], like(field(table, ^column), ^"%#{value}"))
  end

  def call(scope, {association, column, :not_end}, value) do
    scope |> where([{^association, table}], not like(field(table, ^column), ^"%#{value}"))
  end

  def call(scope, {association, column, :gt}, value) do
    scope |> where([{^association, table}], field(table, ^column) > ^value)
  end

  def call(scope, {association, column, :gteq}, value) do
    scope |> where([{^association, table}], field(table, ^column) >= ^value)
  end

  def call(scope, {association, column, :lt}, value) do
    scope |> where([{^association, table}], field(table, ^column) < ^value)
  end

  def call(scope, {association, column, :lteq}, value) do
    scope |> where([{^association, table}], field(table, ^column) <= ^value)
  end

  def call(scope, {association, column, :between}, [first | last]) do
    scope
    |> where(
      [{^association, table}],
      field(table, ^column) >= ^first and
        field(table, ^column) <= ^Enum.at(last, 0)
    )
  end
end
