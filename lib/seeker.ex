defmodule Seeker do
  @moduledoc """
  Documentation for `Seeker`.
  """

  def search(scope, params \\ %{}) do
    Seeker.Search.call(scope, params)
  end
end
