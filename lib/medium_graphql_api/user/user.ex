defmodule MediumGraphqlApi.User.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query
  alias MediumGraphqlApi.User.User

  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:role, Ecto.Enum, values: [:user, :admin], default: :user)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :password_confirmation, :role])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :role
    ])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> unique_constraint(:email, message: "email_is_already_in_use")
    |> hash_password
  end

  defp hash_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{
          password: password
        }
      } ->
        current_changeset
        |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))

      _ ->
        current_changeset
    end
  end

  def with_email(query, email) do
    query
    |> where([u], u.email == ^email)
  end

  def verify_password(%User{password_hash: nil}, _) do
    {:error, :password_not_set}
  end

  def verify_password(%User{password_hash: _password_hash} = user, password) do
    case Bcrypt.check_pass(user, password) do
      {:ok, _user} = result ->
        result

      _else ->
        Logger.log(:info, "Ivalid password attempted for user #{user.id}", user_id: user.id)
        {:error, :invalid_credentials}
    end
  end
end
