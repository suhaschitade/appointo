defmodule AppointoWeb.StateControllerTest do
  use AppointoWeb.ConnCase

  alias Appointo.States
  alias Appointo.States.State

  @create_attrs %{active: true, name: "some name", threelettercode: "some threelettercode", twolettercode: "some twolettercode"}
  @update_attrs %{active: false, name: "some updated name", threelettercode: "some updated threelettercode", twolettercode: "some updated twolettercode"}
  @invalid_attrs %{active: nil, name: nil, threelettercode: nil, twolettercode: nil}

  def fixture(:state) do
    {:ok, state} = States.create_state(@create_attrs)
    state
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all states", %{conn: conn} do
      conn = get conn, state_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create state" do
    test "renders state when data is valid", %{conn: conn} do
      conn = post conn, state_path(conn, :create), state: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, state_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active" => true,
        "name" => "some name",
        "threelettercode" => "some threelettercode",
        "twolettercode" => "some twolettercode"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, state_path(conn, :create), state: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update state" do
    setup [:create_state]

    test "renders state when data is valid", %{conn: conn, state: %State{id: id} = state} do
      conn = put conn, state_path(conn, :update, state), state: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, state_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active" => false,
        "name" => "some updated name",
        "threelettercode" => "some updated threelettercode",
        "twolettercode" => "some updated twolettercode"}
    end

    test "renders errors when data is invalid", %{conn: conn, state: state} do
      conn = put conn, state_path(conn, :update, state), state: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete state" do
    setup [:create_state]

    test "deletes chosen state", %{conn: conn, state: state} do
      conn = delete conn, state_path(conn, :delete, state)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, state_path(conn, :show, state)
      end
    end
  end

  defp create_state(_) do
    state = fixture(:state)
    {:ok, state: state}
  end
end
