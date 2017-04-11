defmodule Watchnature.Web.Schema do
  use Absinthe.Schema
  import_types Watchnature.Web.Schema.Types

  query do
    @desc "Get all Posts"
    field :posts, list_of(:post) do
      resolve &Watchnature.Web.PostResolver.all/2
    end

    @desc "Get all Users"
    field :users, list_of(:user) do
      resolve &Watchnature.Web.UserResolver.all/2
    end

    @desc "Get a User of the Post"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &Watchnature.Web.UserResolver.find/2
    end
  end
end
