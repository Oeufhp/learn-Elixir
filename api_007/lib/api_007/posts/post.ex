defmodule Api007.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :message, :string

    many_to_many :user , Api007.Users.User, join_through: Api007.UserPosts.UserPosts, on_delete: :delete_all, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
