import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pii_detector, PiiDetectorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ZKNBx0XJlAmX3b62BXl4kz7pW0aI5F3x1xwFj0MR9lhNz/SiItk8kBVQ6oXYvb/c",
  server: false

# In test we don't send emails.
config :pii_detector, PiiDetector.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
