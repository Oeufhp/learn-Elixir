defmodule Api007Web.Router do
  use Api007Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Api007Web do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create]
    post "/users/:id", UserController, :update
    post "/users/posts/:id", UserController, :upsert_user_posts
    resources "/posts", PostController, only: [:index, :show, :create]
    post "/posts/:id", PostController, :update
    post "/posts/users/:id", PostController, :upsert_post_users
  end
end
