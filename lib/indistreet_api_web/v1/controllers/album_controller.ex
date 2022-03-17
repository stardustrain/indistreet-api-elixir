defmodule IndistreetApiWeb.V1.AlbumController do
  use IndistreetApiWeb, :controller
  import Utils.Pagination
  alias IndistreetApi.Music

  def index(conn, params) do
    option = get_pagination_option(%{page: params["page"], offset: params["offset"]})
    albums = Music.list_albums(option)
    render(conn, "index.json", albums: albums)
  end

  def show(conn, %{"id" => id}) do
    album = Music.get_product!(id)
    render(conn, "show.json", album: album)
  end
end
