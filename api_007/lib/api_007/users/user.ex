defmodule Api007.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "userss" do
    field :name, :string

    many_to_many :posts, Api007.Posts.Post, join_through: "user_post", on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
