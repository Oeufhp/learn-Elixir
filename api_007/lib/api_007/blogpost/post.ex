defmodule Api007.Blogpost.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :message, :string
    field :title, :string
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :message, :user_id])
    |> validate_required([:title, :message, :user_id])
  end
end
