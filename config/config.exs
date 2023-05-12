# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pii_detector, ecto_repos: [PiiDetector.Repo]

config :pii_detector, PiiDetector.Repo,
  database: "pii_vault",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10

# Configures the endpoint
config :pii_detector, PiiDetectorWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PiiDetectorWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PiiDetector.PubSub,
  live_view: [signing_salt: "9+6/6mxn"]

# Cloak
config :pii_detector, PiiDetector.Vault,
  ciphers: [
    default:
      {Cloak.Ciphers.AES.GCM,
       tag: "AES.GCM.V1", key: Base.decode64!("8VMOSBPgRMn3bWtdHNCqJ7mLsfdwd31I7y5qU4peI/E=")}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
