defmodule Seeker.Sort do
  @moduledoc """
  Sort implementation for `Seeker`.
  """

  import Ecto.Query, warn: false

  alias Seeker.Extractor

  @default_sort "asc"

  @doc """
  Returns the `s` param key in the connection params. It tries
  to find it by using the string or atom key.

  ## Parameters

    - params: Map [Plug.Conn params]

  ## Examples

      iex> params(%{"s" => "name+asc"})
      "name+asc"

  """
  @spec params(map()) :: String.t()
  def params(%{"s" => params}), do: params
  def params(%{s: params}), do: params
  def params(_params), do: ""

  @doc """
  Adds order statements to the ecto query based on the `s` param.

  ## Parameters

    - scope: Ecto.Query [Ecto query struct]
    - sorts: String [Sort param string]

  ## Examples

      iex> call(scope, sorts)
      %Ecto.Query{}

  """
  @spec call(Ecto.Query.t(), String.t()) :: Ecto.Query.t()
  def call(scope, sorts) do
    sorts
    |> String.split(",", trim: true)
    |> Enum.map(&String.split(&1, "+"))
    |> Enum.map(&extract_order_data/1)
    |> Enum.reduce(scope, &perform_order/2)
  end

  defp extract_order_data([subject | tail]) do
    column = Extractor.column!(subject)
    direction = List.first(tail) || @default_sort
    association = Extractor.association!(subject)
    {association, column, String.to_existing_atom(direction)}
  end

  defp perform_order({association, column, direction}, scope) do
    scope |> order_by([{^association, table}], [{^direction, field(table, ^column)}])
  end
end
