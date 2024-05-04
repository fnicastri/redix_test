# RedixTest

## How to reproduce the issue

- start the docker with `docker compose up -d`
- start the redis monitor with `redis-cli.sh`
- start the elixir application with `iex -S mix phx.server`
- start Redix.PubSub with `{:ok,rec}=Redix.PubSub.start_link([host: "localhost",password: "miTAhlInEWlI", sync_connect: true, name: RedisTest.Redix.PubSub, debug: []])`
- cycle the network with: `redis-test.sh`

Same beahvior starting the Redix.PubSub in from the main Supervisor or in a Genserver.
