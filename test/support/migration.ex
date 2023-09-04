defmodule Seeker.Integration.Migration do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      timestamps()
    end

    create table(:categories) do
      add :name, :string
      timestamps()
    end

    create table(:posts) do
      add :title, :string
      add :status, :string
      add :date, :utc_datetime
      add :author_id, references(:users)
      add :category_id, references(:categories)
      timestamps()
    end

    create table(:comments) do
      add :body, :string
      add :post_id, references(:posts)
      timestamps()
    end
  end
end
