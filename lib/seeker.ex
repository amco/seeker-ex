defmodule Seeker do
  @moduledoc """
  Documentation for `Seeker`.
  """

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      alias Seeker.{Search, Config}

      @otp_app Keyword.fetch!(opts, :otp_app)

      @doc """
      Returns ecto query struct based on passed params.

      ## Parameters

        - scope: Ecto.Schema or Ecto.Query
        - params: Map containing query and sort data.

      ## Examples

          iex> User |> Seeker.query()
          %Ecto.Query{}

      """
      @spec query(atom() | Ecto.Query.t()) :: Ecto.Query.t()
      def query(scope, params \\ %{}) do
        Search.call(scope, params)
      end

      @doc """
      Returns query results based on passed params.

      ## Parameters

        - scope: Ecto.Schema or Ecto.Query
        - params: Map containing query and sort data.

      ## Examples

          iex> User |> Seeker.all()
          [%User{}, %User{}]

      """
      @spec all(atom() | Ecto.Query.t()) :: list(atom()) | list([])
      def all(scope, params \\ %{}) do
        with repo <- Keyword.fetch!(config(), :repo) do
          apply(repo, :all, [query(scope, params)])
        end
      end

      defp config do
        Application.fetch_env!(@otp_app, __MODULE__)
      end
    end
  end
end
