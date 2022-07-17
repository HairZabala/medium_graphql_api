defmodule MediumGraphqlApiWeb.Router do
  use MediumGraphqlApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug MediumGraphqlApiWeb.Plug.Context
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphql", Absinthe.Plug, schema: MediumGraphqlApiWeb.Schema)

    if Mix.env() == :dev do
      forward("/graphiql", Absinthe.Plug.GraphiQL, schema: MediumGraphqlApiWeb.Schema)
    end
  end
end
