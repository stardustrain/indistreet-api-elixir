defmodule IndistreetApiWeb.Admin.SongControllerTest do
  use IndistreetApiWeb.ConnCase

  import IndistreetApi.SongFixture
  import IndistreetApi.UserFixture

  setup %{conn: conn} do
    token = admin_user_token_fixture()
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{token}")
    {:ok, conn: conn}
  end

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
