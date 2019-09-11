defmodule Api007Web.Router do
  use Api007Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", Api007Web do
    pipe_through :api
    post "/users/signin", UserController, :signin
    post "/users/verify_structure", UserController, :verify_structure
    post "/users/validate_class", UserController, :validate_class
  end

  scope "/api", Api007Web do
    pipe_through [:api, :api_auth]
    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
  end

  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(Api007Web.ErrorView)
      |> render("401.json", message: "Unauthorized user")
      |> halt()
    end
  end
end
