defmodule IndistreetApiWeb.V1.UserView do
  @moduledoc false

  use IndistreetApiWeb, :view

  def render("signin.json", %{token: token}) do
    %{token: token}
  end
end
