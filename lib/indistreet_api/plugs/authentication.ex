defmodule IndistreetApi.Plugs.Authentication do
  @moduledoc false

  use Guardian.Plug.Pipeline,
      otp_app: :indistreet_api,
      module: IndistreetApi.Guardian,
      error_handler: IndistreetApi.ErrorHandlers.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource
  plug Guardian.Plug.EnsureAuthenticated
end
