defmodule IndistreetApiWeb.Admin.SongControllerTest do
  use IndistreetApiWeb.AdminConnCase

  import IndistreetApi.SongFixture

  describe "retrieve song" do
    setup [:create_song]

    test "should render song with song id", %{conn: conn, song: song} do
      conn = get(
        conn,
        Routes.admin_song_path(conn, :show, "1")
      )

      assert json_response(conn, 200)["id"] == Map.get(song, :id)
    end

    test "should render 404 when does not exist song", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(
          conn,
          Routes.admin_song_path(conn, :show, "-1")
        )
      end
    end
  end

  defp create_song(_) do
    song = song_fixture()
    %{song: song}
  end
end
