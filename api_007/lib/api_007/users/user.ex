defmodule Api007.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string

    many_to_many :posts, Api007.Posts.Post, join_through: Api007.UserPosts.UserPosts, on_delete: :delete_all, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @doc false
  def changeset_update_post(user, posts) do
    user
    |> cast(%{}, [:name])
    |> put_assoc(:posts, posts)
  end
end
