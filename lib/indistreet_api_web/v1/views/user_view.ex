defmodule IndistreetApiWeb.V1.UserView do
  @moduledoc false

  use IndistreetApiWeb, :view

  def render("jwt.json", %{token: token}) do
    %{token: token}
  end
end
