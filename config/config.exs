# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nZ6j+gIMcnJYdhj3OjJdONC/g71dLiW1xuB43B3ils5GymVxQ1yforDOOKAH25a0",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth, 
  providers: [
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth, 
  client_id: "e3fda48bbdde39fd27c4",
  client_secret: "6604c13bfc73f0f7e9ab4e1367b734545f50b128"