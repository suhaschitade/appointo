# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :appointo,
  ecto_repos: [Appointo.Repo]

# Configures the endpoint
config :appointo, AppointoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rInbUmFlqbTWiq1hz30TMJn3EWXk2RnzVoHxY1o+O/Sd0PFshnv5FAh4Ub/nFkvL",
  render_errors: [view: AppointoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Appointo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Appointo.Coherence.User,
  repo: Appointo.Repo,
  module: Appointo,
  web_module: AppointoWeb,
  router: AppointoWeb.Router,
  messages_backend: AppointoWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, AppointoWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"

  config :ex_admin,
  repo: Appointo.Repo,
  module: AppointoWeb,    # MyProject.Web for phoenix >= 1.3.0-rc 
  modules: [
    Appointo.ExAdmin.Dashboard,
    Appointo.ExAdmin.User,
    Appointo.ExAdmin.Role,
    Appointo.ExAdmin.Country,
    Appointo.ExAdmin.State,
  ]
  config :xain, :after_callback, {Phoenix.HTML, :raw}

# %% End Coherence Configuration %%


config :phoenix_oauth2_provider, PhoenixOauth2Provider,
  module: Appointo,
  current_resource_owner: :current_user,
  repo: Appointo.Repo,
  resource_owner: Appointo.Coherence.User

