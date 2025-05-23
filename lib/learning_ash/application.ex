defmodule LearningAsh.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LearningAshWeb.Telemetry,
      LearningAsh.Repo,
      {DNSCluster, query: Application.get_env(:learning_ash, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LearningAsh.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LearningAsh.Finch},
      # Start a worker by calling: LearningAsh.Worker.start_link(arg)
      # {LearningAsh.Worker, arg},
      # Start to serve requests, typically the last entry
      LearningAshWeb.Endpoint,
      {Absinthe.Subscription, LearningAshWeb.Endpoint},
      AshGraphql.Subscription.Batcher,
      {AshAuthentication.Supervisor, [otp_app: :learning_ash]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LearningAsh.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LearningAshWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
