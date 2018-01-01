defmodule AppointoWeb.CountryControllerTest do
  use AppointoWeb.ConnCase

  alias Appointo.Countries
  alias Appointo.Countries.Country

  @create_attrs %{active: true, name: "some name", threelettercode: "some threelettercode", twolettercode: "some twolettercode"}
  @update_attrs %{active: false, name: "some updated name", threelettercode: "some updated threelettercode", twolettercode: "some updated twolettercode"}
  @invalid_attrs %{active: nil, name: nil, threelettercode: nil, twolettercode: nil}

  def fixture(:country) do
    {:ok, country} = Countries.create_country(@create_attrs)
    country
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all countries", %{conn: conn} do
      conn = get conn, country_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create country" do
    test "renders country when data is valid", %{conn: conn} do
      conn = post conn, country_path(conn, :create), country: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, country_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active" => true,
        "name" => "some name",
        "threelettercode" => "some threelettercode",
        "twolettercode" => "some twolettercode"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, country_path(conn, :create), country: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update country" do
    setup [:create_country]

    test "renders country when data is valid", %{conn: conn, country: %Country{id: id} = country} do
      conn = put conn, country_path(conn, :update, country), country: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, country_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active" => false,
        "name" => "some updated name",
        "threelettercode" => "some updated threelettercode",
        "twolettercode" => "some updated twolettercode"}
    end

    test "renders errors when data is invalid", %{conn: conn, country: country} do
      conn = put conn, country_path(conn, :update, country), country: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete country" do
    setup [:create_country]

    test "deletes chosen country", %{conn: conn, country: country} do
      conn = delete conn, country_path(conn, :delete, country)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, country_path(conn, :show, country)
      end
    end
  end

  defp create_country(_) do
    country = fixture(:country)
    {:ok, country: country}
  end
end
