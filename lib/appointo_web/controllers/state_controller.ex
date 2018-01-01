defmodule AppointoWeb.StateController do
  use AppointoWeb, :controller

  alias Appointo.States
  alias Appointo.States.State

  action_fallback AppointoWeb.FallbackController

  def index(conn, _params) do
    states = States.list_states()
    render(conn, "index.json", states: states)
  end

  def create(conn, %{"state" => state_params}) do
    with {:ok, %State{} = state} <- States.create_state(state_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", state_path(conn, :show, state))
      |> render("show.json", state: state)
    end
  end

  def show(conn, %{"id" => id}) do
    state = States.get_state!(id)
    render(conn, "show.json", state: state)
  end

  def update(conn, %{"id" => id, "state" => state_params}) do
    state = States.get_state!(id)

    with {:ok, %State{} = state} <- States.update_state(state, state_params) do
      render(conn, "show.json", state: state)
    end
  end

  def delete(conn, %{"id" => id}) do
    state = States.get_state!(id)
    with {:ok, %State{}} <- States.delete_state(state) do
      send_resp(conn, :no_content, "")
    end
  end
end
