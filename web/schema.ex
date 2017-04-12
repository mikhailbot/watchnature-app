defmodule Watchnature.Web.Schema do
  use Absinthe.Schema
  alias Watchnature.Web.{PostResolver, UserResolver}
  import_types Watchnature.Web.Schema.Types

  query do
    @desc "Get all Posts"
    field :posts, list_of(:post) do
      resolve &PostResolver.all/2
    end

    @desc "Get a Post"
    field :post, type: :post do
      arg :id, non_null(:id)
      resolve &PostResolver.find/2
    end

    @desc "Get all Users"
    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end

    @desc "Get a User of the Post"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &UserResolver.find/2
    end
  end

  mutation do
    @desc "Create a Post"
    field :post, type: :post do
      arg :description, non_null(:string)

      resolve &PostResolver.create/2
    end
  end
end
