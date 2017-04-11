defmodule Watchnature.Web.PostResolver do
  alias Watchnature.{Repo, Post}

  def all(_args, _info) do
    {:ok, Repo.all(Post) |> Repo.preload(:user) }
  end
end
