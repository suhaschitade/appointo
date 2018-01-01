defmodule AppointoWeb.CountryController do
  use AppointoWeb, :controller

  alias Appointo.Countries
  alias Appointo.Countries.Country

  action_fallback AppointoWeb.FallbackController

  def index(conn, _params) do
    countries = Countries.list_countries()
    render(conn, "index.json", countries: countries)
  end

  def create(conn, %{"country" => country_params}) do
    with {:ok, %Country{} = country} <- Countries.create_country(country_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", country_path(conn, :show, country))
      |> render("show.json", country: country)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Countries.get_country!(id)
    render(conn, "show.json", country: country)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Countries.get_country!(id)

    with {:ok, %Country{} = country} <- Countries.update_country(country, country_params) do
      render(conn, "show.json", country: country)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Countries.get_country!(id)
    with {:ok, %Country{}} <- Countries.delete_country(country) do
      send_resp(conn, :no_content, "")
    end
  end
end
