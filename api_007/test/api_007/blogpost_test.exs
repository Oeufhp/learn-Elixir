defmodule Api007.BlogpostTest do
  use Api007.DataCase

  alias Api007.Blogpost

  describe "posts" do
    alias Api007.Blogpost.Post

    @valid_attrs %{message: "some message", title: "some title", user_id: "some user_id"}
    @update_attrs %{message: "some updated message", title: "some updated title", user_id: "some updated user_id"}
    @invalid_attrs %{message: nil, title: nil, user_id: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogpost.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blogpost.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blogpost.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blogpost.create_post(@valid_attrs)
      assert post.message == "some message"
      assert post.title == "some title"
      assert post.user_id == "some user_id"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogpost.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blogpost.update_post(post, @update_attrs)
      assert post.message == "some updated message"
      assert post.title == "some updated title"
      assert post.user_id == "some updated user_id"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogpost.update_post(post, @invalid_attrs)
      assert post == Blogpost.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blogpost.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blogpost.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blogpost.change_post(post)
    end
  end
end
