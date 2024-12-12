defmodule Seeker.Extractor do
  @moduledoc """
  Extractor implementation for `Seeker`.
  """

  @column_regex ~r/__([a-z_]+)$/
  @association_regex ~r/^([a-z_]+)__/

  @doc """
  Returns atom column name based on a string key.

  ## Parameters

    - key: String

  ## Examples

      iex> column!("category__name")
      :name

      iex> column!("email")
      :email

  """
  @spec column!(String.t()) :: atom()
  def column!(key), do: column(key) |> elem(1)

  @doc """
  Returns atom column name tuple based on a string key.

  ## Parameters

    - key: String

  ## Examples

      iex> column("category__name")
      {:ok, :name}

      iex> column("email")
      {:ok, :email}

  """
  @spec column(String.t()) :: {:ok, atom()}
  def column(key) do
    case Regex.run(@column_regex, key) do
      [_, column] -> {:ok, String.to_existing_atom(column)}
      nil -> {:ok, String.to_existing_atom(key)}
    end
  end

  @doc """
  Returns atom association name based on a string key.

  ## Parameters

    - key: String

  ## Examples

      iex> association!("category__name")
      :category

      iex> association!("email")
      :root

  """
  @spec association!(String.t()) :: atom()
  def association!(key), do: association(key) |> elem(1)

  @doc """
  Returns atom association name tuple based on a string key.

  ## Parameters

    - key: String

  ## Examples

      iex> association("category__name")
      {:ok, :category}

      iex> association("email")
      {:ok, :root}

  """
  @spec association(String.t()) :: {:ok, atom()}
  def association(key) do
    case Regex.run(@association_regex, key) do
      [_, assoc] -> {:ok, String.to_existing_atom(assoc)}
      nil -> {:ok, :root}
    end
  end
end
