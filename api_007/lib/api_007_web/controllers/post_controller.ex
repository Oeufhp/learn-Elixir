defmodule Api007Web.PostController do
  use Api007Web, :controller

  alias Api007.Blogpost
  alias Api007.Blogpost.Post

  action_fallback Api007Web.FallbackController

  def index(conn, _params) do
    posts = Blogpost.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Blogpost.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blogpost.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blogpost.get_post!(id)

    with {:ok, %Post{} = post} <- Blogpost.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blogpost.get_post!(id)

    with {:ok, %Post{}} <- Blogpost.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
