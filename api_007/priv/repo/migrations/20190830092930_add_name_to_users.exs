defmodule Api007.Repo.Migrations.AddNameToUsers do
  use Ecto.Migration

  def change do
		alter table(:users) do
			add :name, :string
		end
  end
end