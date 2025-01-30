Logger.configure(level: :info)

alias Seeker.Integration.Repo

Application.put_env(:ecto, :primary_key_type, :id)
Application.put_env(:ecto, :async_integration_tests, false)

Application.put_env(:seeker, Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: System.get_env("DB_HOSTNAME", "localhost"),
  database: System.get_env("DB_DATABASE", "seeker"),
  username: System.get_env("DB_USERNAME", "postgres"),
  password: System.get_env("DB_PASSWORD", ""),
  port: System.get_env("DB_PORT", "5434"),
  pool: Ecto.Adapters.SQL.Sandbox,
  show_sensitive_data_on_connection_error: true
)

# Load up the repository, start it, and run migrations
:ok = Ecto.Adapters.Postgres.storage_down(Repo.config())
:ok = Ecto.Adapters.Postgres.storage_up(Repo.config())

{:ok, _} = Repo.start_link()
:ok = Ecto.Migrator.up(Repo, 0, Seeker.Integration.Migration, log: false)

ExUnit.start()
