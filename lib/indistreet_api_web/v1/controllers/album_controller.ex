defmodule IndistreetApiWeb.V1.AlbumController do
  use IndistreetApiWeb, :controller
  alias Utils.Pagination
  alias IndistreetApi.V1.Music

  def index(conn, params) do
    option = Pagination.get_pagination_option(%{page: params["page"], offset: params["offset"]})
    albums = Music.list_albums(option)
    render(conn, "index.json", albums: albums)
  end

  def show(conn, %{"id" => id}) do
    album = Music.get_album!(id)
    render(conn, "show.json", album: album)
  end
end
