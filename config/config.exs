# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :watchnature,
  ecto_repos: [Watchnature.Repo]

# Configures the endpoint
config :watchnature, Watchnature.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pleZSV6qhDu0Sv+Reyy2LSaSI5+6RhFe1vrB4mur735GxmTzhJ020lV1mHok1OWp",
  render_errors: [view: Watchnature.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Watchnature.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    identity: {
      Ueberauth.Strategy.Identity,
      [callback_methods: ["POST"]]
    }
  ]

config :guardian, Guardian,
  issuer: "Watchnature",
  ttl: {30, :days},
  secret_key: "uw/27wdrIquPn2fktwfJg9tg8qOl5ysTPCFjISw1TCCaLlfWgRUAea1SuWcfERzX",
  serializer: Watchnature.GuardianSerializer,
  permissions: %{default: [:read, :write]}

config :cloudex,
  api_key: System.get_env("CLOUDEX_API_KEY"),
  secret: System.get_env("CLOUDEX_SECRET"),
  cloud_name: System.get_env("CLOUDEX_CLOUD_NAME")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
