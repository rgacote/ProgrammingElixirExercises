import Config

config :issues,
  github_url: "https://api.github.com"

config :logger,
  compile_time_purge_level: :info

# For importing mode-specific configurations.
# import_config "#{config_env()}.exs"
