defmodule Appointo.CountriesTest do
  use Appointo.DataCase

  alias Appointo.Countries

  describe "countries" do
    alias Appointo.Countries.Country

    @valid_attrs %{active: true, name: "some name", threelettercode: "some threelettercode", twolettercode: "some twolettercode"}
    @update_attrs %{active: false, name: "some updated name", threelettercode: "some updated threelettercode", twolettercode: "some updated twolettercode"}
    @invalid_attrs %{active: nil, name: nil, threelettercode: nil, twolettercode: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Countries.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Countries.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Countries.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Countries.create_country(@valid_attrs)
      assert country.active == true
      assert country.name == "some name"
      assert country.threelettercode == "some threelettercode"
      assert country.twolettercode == "some twolettercode"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Countries.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, country} = Countries.update_country(country, @update_attrs)
      assert %Country{} = country
      assert country.active == false
      assert country.name == "some updated name"
      assert country.threelettercode == "some updated threelettercode"
      assert country.twolettercode == "some updated twolettercode"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Countries.update_country(country, @invalid_attrs)
      assert country == Countries.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Countries.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Countries.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Countries.change_country(country)
    end
  end
end
