defmodule Api007.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :message, :string

    many_to_many :user , Api007.Users.User, join_through: "user_post", on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
