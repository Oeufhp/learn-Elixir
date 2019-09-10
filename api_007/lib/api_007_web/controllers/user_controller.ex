defmodule Api007Web.UserController do
  use Api007Web, :controller

  alias Api007.Auth
  alias Api007.Auth.User

  action_fallback Api007Web.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user}) do
    with {:ok, %User{} = user} <- Auth.create_user(user) do
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

	def verify_structure(conn, %{"structure" => structure, "required_type_list" => required_type_list}) do
		map_ja = Enum.map(structure, fn(each) -> 
			# if each["type"] == nil do
			# 	"no type found"
			# else
			# 	is_required_type(each["type"], required_type_list)
			# end
			case each["type"] do
				nil -> %{
					key: each["key"],
					is_type_contain: false
				}
				_ -> %{
					key: each["key"],
					is_type_contain: is_required_type(each["type"], required_type_list)
				}
			end
		end
		)
		render(conn, "result.json", result: map_ja)
	end

	defp is_required_type(each_value, required_list) do
		Enum.member?(required_list, each_value)
	end
end
