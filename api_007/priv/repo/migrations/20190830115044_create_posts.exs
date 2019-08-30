defmodule Api007.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :message, :string
      add :user_id, :string

      timestamps()
    end

  end
end
