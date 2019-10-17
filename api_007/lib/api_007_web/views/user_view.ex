defmodule Api007Web.UserView do
  use Api007Web, :view
  alias Api007Web.UserView

  def render("index.json", %{userss: userss}) do
    %{data: render_many(userss, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      posts: user.posts
    }
  end
end
