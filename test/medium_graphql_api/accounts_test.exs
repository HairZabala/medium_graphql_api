defmodule MediumGraphqlApi.AccountsTest do
  use MediumGraphqlApi.DataCase

  alias MediumGraphqlApi.User.UserContext

  describe "users" do
    alias MediumGraphqlApi.User.User

    import MediumGraphqlApi.AccountsFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil}

  end
end
