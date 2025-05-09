import Config
config :learning_ash, token_signing_secret: "xt1pQxZH6MajTLBEG1SKC8d1z1FdWD8j"
config :bcrypt_elixir, log_rounds: 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :learning_ash, LearningAsh.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "learning_ash_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :learning_ash, LearningAshWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "JwUzz9jBHEwt7ISKd4rYRHYX0COjvVH1itCSAnAsk76zsy/P/NIDidT5sRyJuWF+",
  server: false

# In test we don't send emails
config :learning_ash, LearningAsh.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
