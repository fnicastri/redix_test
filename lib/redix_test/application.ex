defmodule RedixTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RedixTestWeb.Telemetry,
      RedixTest.Repo,
      {DNSCluster, query: Application.get_env(:redix_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RedixTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RedixTest.Finch},
      # Start a worker by calling: RedixTest.Worker.start_link(arg)
      # {RedixTest.Worker, arg},
      # Redix
      {Redix, Application.get_env(:redix_test, RedixTest.Redix.PubSub) ++ [name: :redix]},
      # %{
      #   id: RedixTest.Redix.PubSub,
      #   # start: {Redix.PubSub, :start_link, Application.get_env(:redix_test, RedixTest.Redix.PubSub)},
      #   start: {
      #     Redix.PubSub,
      #     :start_link,
      #     [
      #       Application.get_env(:post_office, RedixTest.Redix.PubSub) ++
      #         [
      #           name: RedixTest.Redix.PubSub,
      #           exit_on_disconnection: false
      #         ]
      #     ]
      #   },
      #   restart: :permanent,
      #   shutdown: 5_000,
      #   type: :worker
      # },
      # Start to serve requests, typically the last entry
      RedixTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RedixTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RedixTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
