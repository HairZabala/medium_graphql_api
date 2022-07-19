defmodule MediumGraphqlApi.Middleware.Authorize do
  @moduledoc false

  @behaviour Absinthe.Middleware

  @doc """
  Extremely important call that checks if the user has been put in the context
  The only way that a user can be put in the context is if they have a valid auth token.
  """
  def call(resolution, allowed_user_types) do
    case resolution.context do
      %{current_user: current_user} ->
        IO.inspect(current_user)

        if allowed_user_types |> Enum.member?(current_user.role) do
          resolution
        else
          resolution
          |> Absinthe.Resolution.put_result({:error, "unauthorized"})
        end

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end
end
