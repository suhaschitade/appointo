defmodule AppointoWeb.API.V1.UserController do
  use AppointoWeb, :controller

  alias Appointo.Users
  alias Appointo.Coherence.User

  action_fallback AppointoWeb.FallbackController

  def index(conn, _params) do
    users = [ExOauth2Provider.Plug.current_resource_owner(conn)]
    render(conn, "index.json", users: users)
  end

end
