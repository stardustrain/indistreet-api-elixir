defmodule IndistreetApi.Guardian do
  @moduledoc false

  use Guardian, otp_app: :indistreet_api
  alias IndistreetApi.V1.Account

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = Account.get_user_by_id!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
