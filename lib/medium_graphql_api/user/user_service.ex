defmodule MediumGraphqlApi.User.UserService do
  @moduledoc false

  require Logger
  alias MediumGraphqlApi.User.{User, UserContext}
  alias MediumGraphqlApi.Guardian
  
  def login(%{email: email, password: password}) do
    case UserContext.get_user_by_email(email) do
      %User{} = user ->
        with {:ok, %User{} = user} <- User.verify_password(user, password),
             {:ok, token, _} <- Guardian.encode_and_sign(user) do
          Logger.log(
            :info,
            "User #{user.id} logged in",
            user_id: user.id
          )

          {
            :ok,
            %{
              token: token,
              user: user
            }
          }
        end

      nil ->
        Logger.log(:info, "Failed login attempt for non-existing email #{email}")
        {:error, :invalid_credentials}
    end
  end

end
