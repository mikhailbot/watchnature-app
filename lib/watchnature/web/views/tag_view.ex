defmodule Watchnature.Web.TagView do
  use Watchnature.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, Watchnature.Web.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, Watchnature.Web.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name,
      type: tag.type}
  end
end
