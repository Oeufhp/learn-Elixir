defmodule Api007.Repo.Migrations.UserPost do
  use Ecto.Migration

  def change do
    create table(:user_post, primary_key: false) do
      add :user_id, references(:userss)
      add :post_id, references(:posts)

      timestamps()
    end
  end
end
