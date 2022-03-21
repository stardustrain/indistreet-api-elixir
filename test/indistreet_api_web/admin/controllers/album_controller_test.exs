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
  end

  describe "update album" do
    setup [:create_album]

    test "should render updated album when data is valid", %{conn: conn, album: album} do
      conn = patch(
        conn,
        Routes.admin_album_path(conn, :update, album),
        %{album: %{name: "Update name", album_type: "EP", description: "Update description"}}
      )
      assert %{
         "album_type" => "EP",
         "description" => "Update description",
         "id" => 1,
         "inserted_at" => iso_date_time(),
         "name" => "Update name",
         "updated_at" => iso_date_time()
       } == json_response(conn, 200)["data"]
    end
  end

  defp create_album(_) do
    album = album_fixture()
    %{album: album}
  end

  defp iso_date_time() do
    DateTime.now!("Etc/UTC")
    |> DateTime.truncate(:second)
    |> DateTime.to_iso8601
  end
end
