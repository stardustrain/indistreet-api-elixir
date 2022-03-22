defmodule IndistreetApiWeb.Admin.AlbumController do
  @moduledoc false
  use IndistreetApiWeb, :controller
  alias IndistreetApi.Music
  alias IndistreetApi.Music.Album

  action_fallback IndistreetApiWeb.Admin.FallbackController

  def create(conn, %{"album" => album_params}) do
    with {:ok, %Album{} = album} <- Music.create_album(album_params) do
      conn
      |> put_status(:created)
      |> render("show.json", album: album)
    else
      {:error, %Ecto.Changeset{}} -> {:error, :bad_request}
    end
  end

  def update(conn, %{"id" => id, "album" => album_params}) do
    album = Music.get_product!(id)
    with {:ok, %Album{} = album} <- Music.update_album(album, album_params) do
      conn
      |> render("show.json", album: album)
    else
      {:error, %Ecto.Changeset{}} -> {:error, :unprocessable_entity}
    end
  end
end
