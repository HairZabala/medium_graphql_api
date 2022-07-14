defmodule MediumGraphqlApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MediumGraphqlApi.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        firt_name: "some firt_name",
        last_name: "some last_name",
        password_hash: "some password_hash",
        role: "some role"
      })
      |> MediumGraphqlApi.Accounts.create_user()

    user
  end
end
