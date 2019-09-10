defmodule Api007Web.UserView do
  use Api007Web, :view
  alias Api007Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      password: user.password,
      is_active: user.is_active}
	end

	def render("signin.json", %{user: user}) do
    %{
      data: %{
        user: %{
          name: user.name,
          email: user.email
        }
      }
    }
	end
	def render("result.json", %{result: result}) do
			%{
				result: result
			}
	end
end
