import Config

config :drywell, Drywell.Repo,
  database: "drywell_repo",
  username: "postgres",
  password: "",
  hostname: "localhost"

config :drywell, ecto_repos: [Drywell.Repo]
