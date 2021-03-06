defmodule IndistreetApiWeb.Admin.AlbumController do
  @moduledoc false
  use IndistreetApiWeb, :controller
  alias IndistreetApi.Admin.Music
  alias IndistreetApi.Model.Music.Album
  alias Utils.Pagination

  action_fallback IndistreetApiWeb.FallbackController

  def create(conn, %{"album" => album_params}) do
    with {:ok, %Album{} = album} <- Music.create_album(album_params) do
      conn
      |> put_status(:created)
      |> render("show.json", album: album)
    end
  end

  def index(conn, params) do
    option = Pagination.get_pagination_option(%{page: params["page"], offset: params["offset"]})
    albums_data = Music.list_albums(option)
    conn
    |> render("index.json", albums_data: albums_data)
  end

  def show(conn, %{"id" => id}) do
    album = Music.get_album!(id)
    conn
    |> render("show.json", album: album)
  end

  def update(conn, %{"id" => id, "album" => album_params}) do
    album = Music.get_album!(id)
    with {:ok, %Album{} = album} <- Music.update_album(album, album_params) do
      conn
      |> render("show.json", album: album)
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, :unprocessable_entity, changeset}
    end
  end

  def delete(conn, %{"id" => id}) do
    album = Music.get_album!(id)
    with {:ok, %Album{} = album} <- Music.delete_album(album) do
      conn
      |> render("show.json", album: album)
    end
  end
end
