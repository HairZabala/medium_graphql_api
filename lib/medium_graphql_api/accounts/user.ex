defmodule MediumGraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:firt_name, :string)
    field(:last_name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:role, :string, default: "user")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firt_name, :last_name, :email, :password, :password_confirmation, :role])
    |> validate_required([:firt_name, :last_name, :email, :password, :password_confirmation, :role])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> unique_constraint(:email, message: "email_is_already_in_use")
    |> hash_password

  end

  defp hash_password(changeset) do
    changeset
  end

end
