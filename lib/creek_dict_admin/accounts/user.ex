defmodule CreekDictAdmin.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bcrypt

  schema "users" do
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash])
    |> validate_required([:username, :password_hash])
    |> unique_constraint(:username)
    |> update_change(:password_hash, &Bcrypt.hash_pwd_salt/1)
  end
end
