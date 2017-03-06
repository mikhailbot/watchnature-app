defmodule Watchnature.PostView do
  use Watchnature.Web, :view
  require IEx

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, Watchnature.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, Watchnature.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    location = case post.location do
      %Geo.Point{coordinates: {lat, lng}} -> %{lat: lat, lng: lng}
      nil -> %{lat: nil, lng: nil}
    end

    %{id: post.id,
      description: post.description,
      location: location,
      user: render_one(post.user, Watchnature.UserView, "user.json")}
  end
end
