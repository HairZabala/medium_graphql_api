defmodule MediumGraphqlApi.User.UserResolver do
  alias MediumGraphqlApi.User.UserContext

  def users(_parent, _args, _resolution) do
    {:ok, UserContext.list_users()}
  end
end
