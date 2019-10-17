defmodule Api007.Repo.Migrations.Createusers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string

      timestamps()
    end

  end
end
