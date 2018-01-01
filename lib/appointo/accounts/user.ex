defmodule Appointo.Accounts.User do
  use Ecto.Schema
  use Coherence.Schema
  import Ecto.Changeset
  alias Appointo.Accounts.User
  alias Appointo.Accounts.Role


  schema "users" do
    field :active, :boolean, default: false
    field :email, :string
    field :name, :string
    coherence_schema
    many_to_many :roles, Role, join_through: "users_roles"

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email] ++ coherence_fields)
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_coherence(attrs)
  end
  def changeset(model, params, :password) do
    model
    |> cast(params, ~w(password password_confirmation reset_password_token reset_password_sent_at))
    |> validate_coherence_password_reset(params)
  end
end
