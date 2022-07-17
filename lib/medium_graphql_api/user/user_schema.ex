defmodule MediumGraphqlApi.User.UserSchema do
  use Absinthe.Schema.Notation
  alias MediumGraphqlApi.Middleware.EctoErrors

  # ==== Return Types ====

  object :user_type do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:role, :string)
  end

  # ==== Input Types ====
  input_object :user_input_type do
    field(:first_name, non_null(:string))
    field(:last_name, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
  end

  # ==== Query Types ====
  object :user_queries do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      # Resolver
      resolve(&MediumGraphqlApi.User.UserResolver.users/3)
    end
  end

  # ==== Mutation Types ====
  object :user_mutations do
    @desc "Creates a new user"
    field :register_user, non_null(:user_type) do
      arg(:input, non_null(:user_input_type))
      resolve(&MediumGraphqlApi.User.UserResolver.register_new_user/3)
      middleware(EctoErrors, [])
    end
  end
end
