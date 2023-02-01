import Config

config :noaa,
  base_url: "https://w1.weather.gov/xml/current_obs"

config :logger,
  compile_time_purge_matching: [
    [lower_level_than: :info]
  ]

# For importing mode-specific configurations.
# import_config "#{config_env()}.exs"
