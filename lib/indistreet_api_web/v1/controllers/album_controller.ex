defmodule IndistreetApiWeb.V1.AlbumController do
  use IndistreetApiWeb, :controller

  alias IndistreetApi.Album

  def index(conn, _params) do
    albums = Album.list_albums()
    render(conn, "index.json", albums: albums)
  end

  def show(conn, %{"id" => id}) do
    album = Album.get_product!(id)
    render(conn, "show.json", album: album)
  end
end
