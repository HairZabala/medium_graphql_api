defmodule MediumGraphqlApi.Guardian do
  @moduledoc false

  use Guardian, otp_app: :medium_graphql_api

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end
end
