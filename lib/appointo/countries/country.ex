defmodule Appointo.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias Appointo.Countries.Country
  alias Appointo.States.State


  schema "countries" do
    field :active, :boolean, default: false
    field :name, :string
    field :threelettercode, :string
    field :twolettercode, :string
    has_many :states, State, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Country{} = country, attrs) do
    country
    |> cast(attrs, [:name, :twolettercode, :threelettercode, :active])
    |> validate_required([:name, :twolettercode, :threelettercode, :active])
  end
end
