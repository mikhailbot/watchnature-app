defmodule Watchnature.Web.PostResolver do
  alias Watchnature.{Repo, Post}

  def all(_args, _info) do
    {:ok, Repo.all(Post) |> Repo.preload(:user) }
  end

  def find(%{id: id}, _info) do
    post = Repo.get(Post, id) |> Repo.preload(:user)

    case post do
      nil -> {:error, "Post #{id} not found"}
      user -> {:ok, user}
    end
  end

  def create(args, _info) do
    %Post{}
    |> Post.changeset(args)
    |> Repo.insert
  end
end
