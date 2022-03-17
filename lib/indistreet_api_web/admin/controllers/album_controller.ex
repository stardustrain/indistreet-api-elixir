defmodule IndistreetApiWeb.Admin.AlbumController do
  @moduledoc false
  use IndistreetApiWeb, :controller
  alias IndistreetApi.Music
  alias IndistreetApi.Music.Album

  def create(conn, %{album: album_params}) do
    with {:ok, %Album{} = album} <- Music.create_album(album_params) do
      conn
      |> put_status(:created)
      |> render("show.json", album: album)
    end
  end
end
