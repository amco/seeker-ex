# Seeker

**TODO: Add description**

## Installation

Add `seeker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:seeker, "~> 0.1.0"}
  ]
end
```

## Configuration

Provide a repo in your configuration file:

```elixir
# config/config.exs

config :my_app, MyApp.Seeker, repo: MyApp.Repo
```

## Usage

Add a `MyApp.Seeker` module as the following example:

```elixir
# lib/my_app/seeker.ex

defmodule MyApp.Seeker do
  use Seeker, otp_app: :my_app
end
```

Assuming a params map with the following structure:

```elixir
%{
  q: %{
    first_name_eq: "Foo",
    email_end: "gmail.com",
    status_in: ["premium", "plus"]
  },
  s: "last_name+asc"
}
```

In your controller, use `all/2` function like this:

```elixir
defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller

  alias MyApp.Seeker
  alias MyApp.Accounts.User

  def index(conn, params) do
    users = User |> Seeker.all(params)
    render(conn, :index, users: users)
  end
end
```

Use `query/2` function when performing queries after using `Seeker` or
using pagination. Like this:

```elixir
defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller

  alias MyApp.Accounts.User
  alias MyApp.{Seeker, Repo}

  def index(conn, params) do
    page =
      User
      |> Seeker.query(params)
      |> Repo.paginate(params)

    render(conn, :index, page: page)
  end
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/seeker>.

