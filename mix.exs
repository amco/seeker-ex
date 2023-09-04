defmodule Seeker.MixProject do
  use Mix.Project

  @source_url "https://github.com/amco/seeker-ex"
  @version "0.1.0"

  def project do
    [
      app: :seeker,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs(),
      source_url: @source_url,
      homepage_url: @source_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:postgrex, ">= 0.0.0", only: [:dev, :test]}
    ]
  end

  defp docs do
    [
      main: "readme",
      formatters: ["html"],
      extras: ["CHANGELOG.md", "CONTRIBUTING.md", "README.md"]
    ]
  end

  defp package do
    [
      description: "Ransack implementation for Ecto SQL.",
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "CONTRIBUTING.md", "LICENSE"],
      maintainers: ["Alejandro Gutiérrez"],
      licenses: ["MIT"],
      links: %{
        GitHub: @source_url,
        Changelog: "https://hexdocs.pm/seeker/changelog.html"
      }
    ]
  end
end
