defmodule MediumGraphqlApiWeb.Plug.Context do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  alias MediumGraphqlApi.Guardian
  alias MediumGraphqlApi.User.UserContext
  alias MediumGraphqlApi.User.User

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <-
           get_req_header(conn, "authorization"),
         {:ok, data} <- Guardian.decode_and_verify(token),
         %User{} = user <- get_user(data) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end

  defp get_user(%{"sub" => sub}) do
    case UserContext.get_user!(sub) do
      %User{} = user -> user
      _ -> nil
    end
  end
end
