defmodule MediumGraphqlApi.User.UserResolver do
  alias MediumGraphqlApi.User.{UserService, UserContext}

  def users(_parent, _args, %{context: context}) do
    IO.inspect(context);
    {:ok, UserContext.list_users()}
  end

  def register_new_user(
    _parent, 
    %{input: input},
    _resolution) do
    UserContext.create_user(input)
  end

  def login_mutation(
    _parent, 
    args,
    _resolution) do
    UserService.login(args)
  end
end
