defmodule MediumGraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :firt_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firt_name, :last_name, :email, :password_hash, :role])
    |> validate_required([:firt_name, :last_name, :email, :password_hash, :role])
  end
end
