defmodule MediumGraphqlApi.User.UserContext do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias MediumGraphqlApi.Repo

  alias MediumGraphqlApi.User.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_user_by_email(email) do
    User
    |> User.with_email(String.downcase(email))
    |> Repo.one()
  end
end
