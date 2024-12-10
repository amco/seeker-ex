defmodule Seeker.PredicateNotFoundError do
  defexception [:key]

  def message(exception) do
    "Search predicate not found for: #{exception.key}"
  end
end
