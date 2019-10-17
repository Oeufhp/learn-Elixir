defmodule Api007.UserPosts.UserPosts do
  use Ecto.Schema
  
  @primary_key false
  schema "user_post" do
    # field :user_id, :integer
    # field :post_id, :integer

    belongs_to :user, Api007.Users.User, [primary_key: true]
    belongs_to :post, Api007.Posts.Post, [primary_key: true]
    
    timestamps()
  end
end