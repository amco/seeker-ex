defmodule Seeker.Extractor do
  @moduledoc """
  Extractor implementation for `Seeker`.
  """

  @column_regex ~r/__([a-z_]+)$/
  @association_regex ~r/^([a-z_]+)__/

  def column!(key), do: column(key) |> elem(1)

  def column(key) do
    case Regex.run(@column_regex, key) do
      [_, column] -> {:ok, String.to_existing_atom(column)}
      nil -> {:ok, String.to_existing_atom(key)}
    end
  end

  def association!(key), do: association(key) |> elem(1)

  def association(key) do
    case Regex.run(@association_regex, key) do
      [_, assoc] -> {:ok, String.to_existing_atom(assoc)}
      nil -> {:ok, :root}
    end
  end
end
