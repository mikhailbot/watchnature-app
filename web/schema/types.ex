defmodule Watchnature.Web.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "A Post"
  object :post do
    field :id, :id
    field :description, :string
    field :user, :user
  end

  @desc "A User"
  object :user do
    field :id, :id
    field :email, :string
    field :posts, list_of(:post)
  end
end
