defmodule Api007.Repo.Migrations.CreateUserss do
  use Ecto.Migration

  def change do
    create table(:userss) do
      add :name, :string

      timestamps()
    end

  end
end
