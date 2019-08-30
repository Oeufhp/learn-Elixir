defmodule Api007Web.UserController do
  use Api007Web, :controller

  alias Api007.Auth
  alias Api007.Auth.User

  action_fallback Api007Web.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

	def render("user.json", %{user: user}) do
		%{id: user.id, email: user.email, is_active: user.is_active}
	end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)

    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
	end

	def signin(conn, %{"email" => email, "password" => password}) do
		case Api007.Auth.authenticate_user(email, password) do
			{:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
				|> put_status(:ok)
				|> put_view(Api007Web.UserView)
				|> render("signin.json", user: user)
			{:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> put_view(Api007Web.ErrorView)
        |> render("401.json", message: message)
		end
	end
end
