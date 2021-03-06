defmodule Watchnature.Web.ObservationView do
  use Watchnature.Web, :view

  def render("index.json", %{observations: observations}) do
    %{data: render_many(observations, Watchnature.Web.ObservationView, "observation.json")}
  end

  def render("show.json", %{observation: observation}) do
    %{data: render_one(observation, Watchnature.Web.ObservationView, "observation.json")}
  end

  def render("observation.json", %{observation: observation}) do
    location = case observation.location do
      %Geo.Point{coordinates: {lat, lng}} -> %{lat: lat, lng: lng}
      nil -> %{lat: nil, lng: nil}
    end

    %{id: observation.id,
      description: observation.description,
      post_id: observation.post_id,
      location_name: observation.location_name,
      location: location
    }
  end
end
