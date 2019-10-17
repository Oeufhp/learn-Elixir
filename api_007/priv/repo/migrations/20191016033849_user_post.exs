defmodule Api007.Repo.Migrations.UserPost do
  use Ecto.Migration

  def change do
    create table(:user_post, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :post_id, references(:posts, on_delete: :delete_all), primary_key: true
      
      timestamps()
    end
    create index(:user_post, [:post_id])
    create index(:user_post, [:user_id])
    create unique_index(:user_post, [:user_id, :post_id], name: :user_id_post_id_unique_index)
  end
end
