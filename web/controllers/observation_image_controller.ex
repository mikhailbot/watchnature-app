defmodule Watchnature.ObservationImageController do
  use Watchnature.Web, :controller

  alias Watchnature.{Observation, ObservationImage}

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :delete]
  plug :scrub_params, "observation_image" when action in [:create]

  def action(conn, _) do
    observation = Repo.get!(Observation, conn.params["observation_id"])
    authorize!(conn, observation)

    args = [conn, conn.params, observation]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _, observation) do
    observation_images = Observation.get_images(observation) |> Repo.all

    render(conn, "index.json", observation_images: observation_images)
  end

  def create(conn, %{"observation_image" => observation_image_params}, observation) do
    observation_images = Observation.get_images(observation) |> Repo.all
    image_path = observation_image_params["image"].path
    # based_image = Base.url_encode64(File.read!(image_path))

    case Cloudex.upload(File.ls(image_path)) do
      [ok: uploaded_image] ->
        conn
        |> put_status(:created)
        |> render("show.json", observation_image: uploaded_image)
      [error: {:invalid, reason}] ->
        conn
        |> put_status(:bad_request)
        |> render(Watchnature.ErrorView, "error.json", title: "Image upload failed", message: reason)
      # _ ->
      #   conn
      #   |> put_status(:bad_request)
      #   |> render(Watchnature.ErrorView, "error.json", title: "Image upload failed")
    end
  end

  def show(conn, _, observation) do
  end

  def destroy(conn, _, observation) do
  end
end
