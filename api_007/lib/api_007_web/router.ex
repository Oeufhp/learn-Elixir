defmodule Api007Web.Router do
  use Api007Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Api007Web do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create]
    post "/users/:id", UserController, :update
    resources "/posts", PostController, only: [:index, :show, :create]
    post "/posts/:id", PostController, :update
  end
end
