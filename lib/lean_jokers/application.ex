defmodule LeanJokers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LeanJokersWeb.Telemetry,
      # Start the Ecto repository
      LeanJokers.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LeanJokers.PubSub},
      # Start Finch
      {Finch, name: LeanJokers.Finch},
      # Start the Endpoint (http/https)
      LeanJokersWeb.Endpoint
      # Start a worker by calling: LeanJokers.Worker.start_link(arg)
      # {LeanJokers.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LeanJokers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LeanJokersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
