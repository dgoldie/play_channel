# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :play_channel,
  ecto_repos: [PlayChannel.Repo]

# Configures the endpoint
config :play_channel, PlayChannelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eE88myYpW7dcgaDOtcYaOhjM+YH6RqULAvCKlyzQI/PcID55rsi/Y76uWeF9IZn1",
  render_errors: [view: PlayChannelWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PlayChannel.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :play_channel,
  context: Inventory
