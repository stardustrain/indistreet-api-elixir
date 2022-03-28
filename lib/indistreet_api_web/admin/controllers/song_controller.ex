defmodule IndistreetApiWeb.Admin.SongController do
  @moduledoc false
  use IndistreetApiWeb, :controller
  alias IndistreetApi.Admin.Music

  action_fallback IndistreetApiWeb.Admin.FallbackController

  def show(conn, %{"id" => id}) do
    song = Music.get_song!(id)

    conn
    |> render("show.json", %{song: song})
  end
end
