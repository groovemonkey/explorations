defmodule Explorations.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ExplorationsWeb.Telemetry,
      # Start the Ecto repository
      Explorations.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Explorations.PubSub},
      # Start Finch
      {Finch, name: Explorations.Finch},
      # Start the Endpoint (http/https)
      ExplorationsWeb.Endpoint
      # Start a worker by calling: Explorations.Worker.start_link(arg)
      # {Explorations.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Explorations.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExplorationsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
