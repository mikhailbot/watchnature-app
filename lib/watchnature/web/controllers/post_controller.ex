defmodule Watchnature.Web.PostController do
  use Watchnature.Web, :controller

  alias Watchnature.{Stream, Post, ErrorView}

  action_fallback Watchnature.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    with :ok <- Bodyguard.permit(Stream, :list_posts, conn) do
      posts = Stream.list_posts()
      render(conn, "index.json", posts: posts)
    end
  end

  def create(conn, %{"post" => post_params}) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    post_params = Map.put_new(post_params, "user_id", user_id)

    with :ok <- Bodyguard.permit(Stream, :create_post, user_id) do
      with {:ok, post} <- Stream.create_post(post_params) do
        conn
        |> put_status(:created)
        |> render("show.json", post: post)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    post = Stream.get_post!(id)

    with :ok <- Bodyguard.permit(Stream, :get_post, conn, post: post) do
      render(conn, "show.json", post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Stream.get_post!(id)

    with :ok <- Bodyguard.permit(Stream, :update_post, conn, post) do
      with {:ok, post} <- Stream.update_post(post, post_params),
       do: render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Stream.get_post!(id)

    with :ok <- Bodyguard.permit(Stream, :delete_post, conn, post) do
      with {:ok, conn} <- Stream.delete_post(post),
       do: send_resp(conn, :no_content, "")
    end
  end
end
