defmodule Api007.Blogpost.Post do
  use Ecto.Schema
  import Ecto.Changeset

	# alias Api007.Auth.User

	schema "posts" do
    field :message, :string
    field :title, :string
		belongs_to :user, Api007.Auth.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :message, :user_id])
		|> validate_required([:title, :message, :user_id])
		|> assoc_constraint(:user)
  end
end
