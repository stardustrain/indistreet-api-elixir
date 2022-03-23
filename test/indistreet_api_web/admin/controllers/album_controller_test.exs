defmodule IndistreetApiWeb.Admin.AlbumControllerTest do
  use IndistreetApiWeb.ConnCase

  import IndistreetApi.AlbumFixture

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create album" do
    test "should render created album when data is valid", %{conn: conn} do
      conn = post(
        conn,
        Routes.admin_album_path(conn, :create),
        %{album: %{name: "New name", album_type: "SINGLE", description: "New description"}}
      )
      assert %{
         "album_type" => "SINGLE",
         "description" => "New description",
         "id" => 1,
         "inserted_at" => iso_date_time(),
         "name" => "New name",
         "updated_at" => iso_date_time()
      } == json_response(conn, 201)["data"]
    end

    test "should render 400 error when data in invalid", %{conn: conn} do
      conn = post(
        conn,
        Routes.admin_album_path(conn, :create),
        %{album: %{}}
      )
      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  describe "listing albums" do
    setup [:create_many_album]

    test "should render all albums with pagination option", %{conn: conn, albums: albums} do
      conn = get(
        conn,
        Routes.admin_album_path(conn, :index),
        %{}
      )
      data = json_response(conn, 200)["data"]
      assert data["count"] == 10
      assert get_album_name(data["albums"]) == get_album_name(albums)
    end

    test "should render empty list with pagination option", %{conn: conn} do
      conn = get(
        conn,
        Routes.admin_album_path(conn, :index),
        %{"page" => 2, "offset" => 10}
      )

      data = json_response(conn, 200)["data"]
      assert data["count"] == 10
      assert data["albums"] == []
    end
  end

  describe "retrieve album" do
    setup [:create_album]

    test "should render album with album id", %{conn: conn, album: album} do
      conn = get(
        conn,
        Routes.admin_album_path(conn, :show, "1")
      )

      assert json_response(conn, 200)["data"]["id"] == Map.get(album, :id)
    end

    test "should render 404 when does not exist album", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(
          conn,
          Routes.admin_album_path(conn, :show, "-1")
        )
      end
    end
  end

  describe "update album" do
    setup [:create_album]

    test "should render updated album when data is valid", %{conn: conn, album: album} do
      conn = patch(
        conn,
        Routes.admin_album_path(conn, :update, album),
        %{album: %{name: "Update name", album_type: "EP", description: "Update description"}}
      )

      updated_album = json_response(conn, 200)["data"]

      assert updated_album["name"] == "Update name"
      assert updated_album["description"] == "Update description"
    end

    test "should render 422 error when data in invalid", %{conn: conn, album: album} do
      conn = patch(
        conn,
        Routes.admin_album_path(conn, :update, album),
        %{album: %{album_type: "WRONG_TYPE"}}
      )
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete album" do
    setup [:create_album]

    test "should render deleted album when exist album", %{conn: conn, album: album} do
      conn = delete(
        conn,
        Routes.admin_album_path(conn, :delete, "1")
      )

      assert json_response(conn, 200)["data"]["id"] == Map.get(album, :id)
    end

    test "should render 404 error when does not exist album", %{conn: conn} do
      assert_error_sent 404, fn ->
        delete(
          conn,
          Routes.admin_album_path(conn, :delete, "-1")
        )
      end
    end
  end

  defp create_album(_) do
    album = album_fixture()
    %{album: album}
  end

  defp create_many_album(_) do
    albums = multiple_album_fixtures()
    %{albums: albums}
  end

  defp iso_date_time() do
    DateTime.now!("Etc/UTC")
    |> DateTime.truncate(:second)
    |> DateTime.to_iso8601
  end

  defp get_album_name(albums) do
    {:ok, album} = Enum.fetch(albums, 1)
    case album do
      album when is_struct(album) ->
        album
        |> Map.from_struct
        |> Map.get(:name)
      _ ->
        album
        |> Map.get("name")
    end
  end
end
