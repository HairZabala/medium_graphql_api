defmodule MediumGraphqlApiWeb.Schema do
  @moduledoc false
  use Absinthe.Schema
  import_types(MediumGraphqlApi.User.UserSchema)

  query do
    import_fields(:user_queries)
  end
end
