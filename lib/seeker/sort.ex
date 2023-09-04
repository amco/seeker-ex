defmodule Seeker.Sort do
  @moduledoc """
  Sort implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  def call(scope, sorts) do
    orders =
      sorts
      |> String.split(",", trim: true)
      |> Enum.map(&String.split(&1, "+"))
      |> Enum.map(&build_order/1)

    perform_order(scope, orders)
  end

  defp perform_order(scope, []), do: scope
  defp perform_order(scope, orders), do: scope |> order_by(^orders)

  defp build_order([column | tail]) do
    direction = List.first(tail) || "asc"
    column = String.to_existing_atom(column)
    {String.to_existing_atom(direction), column}
  end
end
