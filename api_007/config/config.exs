# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_007,
  ecto_repos: [Api007.Repo]

# Configures the endpoint
config :api_007, Api007Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Lhp1vwtDSx769oyIXbn8X51uHP6+XBZQd9jzFfKoOyt5ycqfgR8qIRL/3O3JXXnA",
  render_errors: [view: Api007Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Api007.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
