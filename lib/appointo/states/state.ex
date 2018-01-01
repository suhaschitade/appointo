defmodule Appointo.States.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias Appointo.States.State
  alias Appointo.Countries.Country


  schema "states" do
    field :active, :boolean, default: false
    field :name, :string
    field :threelettercode, :string
    field :twolettercode, :string
    belongs_to :country, Country

    timestamps()
  end

  @doc false
  def changeset(%State{} = state, attrs) do
    state
    |> cast(attrs, [:name, :twolettercode, :threelettercode, :active, :country_id])
    |> validate_required([:name, :twolettercode, :threelettercode, :active, :country_id])
  end
end
