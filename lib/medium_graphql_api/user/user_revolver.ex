defmodule MediumGraphqlApi.User.UserResolver do
  alias MediumGraphqlApi.User.UserContext

  def users(_parent, _args, _resolution) do
    {:ok, UserContext.list_users()}
  end

  def register_new_user(
    _parent, 
    %{input: input},
    _resolution) do
    UserContext.create_user(input)
  end
end
