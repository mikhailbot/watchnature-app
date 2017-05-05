defmodule Watchnature.ObservationImageView do
  use Watchnature.Web, :view

  def render("index.json", %{observation_images: observation_images}) do
    %{data: render_many(observation_images, Watchnature.ObservationImageView, "observation_image.json")}
  end

  def render("show.json", %{observation_image: observation_image}) do
    %{data: render_one(observation_image, Watchnature.ObservationImageView, "observation_image.json")}
  end

  def render("observation_image.json", %{observation_image: observation_image}) do
    %{id: observation_image.id,
      observation_id: observation_image.observation_id}
  end
end
