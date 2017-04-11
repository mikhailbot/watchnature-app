defmodule Watchnature.Web.UserResolver do
  alias Watchnature.{Repo, User}

  def all(_args, _info) do
    {:ok, Repo.all(User) |> Repo.preload(:posts)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(User, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end
end
