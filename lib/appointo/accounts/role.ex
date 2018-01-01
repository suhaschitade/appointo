defmodule Appointo.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Appointo.Accounts.Role
  alias Appointo.Accounts.User

  schema "roles" do
    field :active, :boolean, default: false
    field :name, :string
    many_to_many :users, User, join_through: "users_roles"
    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
