defmodule IndistreetApiWeb.ErrorViewTest do
  use IndistreetApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders error.json" do
    assert render(IndistreetApiWeb.ErrorView, "error.json", %{detail: ["Error reason"]}) === %{errors: ["Error reason"]}
  end

  test "renders 404.json" do
    assert render(IndistreetApiWeb.ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(IndistreetApiWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
