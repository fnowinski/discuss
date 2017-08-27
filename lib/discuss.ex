defmodule Discuss do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Discuss.Repo, []),
      supervisor(Discuss.Endpoint, []),
      supervisor(Discuss.Presence, [])
    ]

    opts = [strategy: :one_for_one, name: Discuss.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Discuss.Endpoint.config_change(changed, removed)
    :ok
  end
end
