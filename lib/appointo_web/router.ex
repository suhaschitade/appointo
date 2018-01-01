defmodule AppointoWeb.Router do
  use AppointoWeb, :router
  use ExAdmin.Router
  use Coherence.Router
 

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  # Add this block
  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

 

  pipeline :api do
    plug :accepts, ["json"]
  end

  

  

 

   # Add this block
   scope "/" do
    pipe_through :protected
    coherence_routes :protected

  end



  scope "/", AppointoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/countries", CountryController, except: [:new, :edit]
    resources "/states", StateController, except: [:new, :edit]
  end

   # your app's routes
   scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes()
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppointoWeb do
  #   pipe_through :api
  # end
end
