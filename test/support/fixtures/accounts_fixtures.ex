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
        email: "hair@google.com",
        first_name: "Hair",
        last_name: "Zabala",
        password: "Abc123",
        password_confirmation: "Abc123",
        role: :user
      })
      |> MediumGraphqlApi.User.UserContext.create_user()

    user
  end
end
