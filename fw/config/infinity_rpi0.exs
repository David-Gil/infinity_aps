use Mix.Config

config :logger, level: :info

config :fw, host_mode: false

config :aps, InfinityAPS.Configuration, file: "/root/infinity_aps.json"

config :aps,
  loop_directory: "/root/loop",
  node_modules_directory: "/usr/lib/node_modules"

config :pummpcomm, :pump, Pummpcomm.Session.Pump
config :pummpcomm, :cgm, Pummpcomm.Session.Pump

config :pummpcomm, :autodetect_chips, [
  %{
    __struct__: RFM69.Device,
    name: :ecc1_phat,
    device: "spidev0.0",
    reset_pin: 24,
    interrupt_pin: 23
  },
  %{__struct__: SubgRfspy.SPI, name: :explorer_board, device: "spidev0.0", reset_pin: 4},
  %{__struct__: SubgRfspy.UART, name: :slice_of_radio, device: "/dev/ttyAMA0"}
]

config :nerves_network, regulatory_domain: "US"

config :nerves_init_gadget, address_method: :static

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: :fw

config :ui, InfinityAPS.UI.Endpoint,
  http: [port: 80],
  url: [host: "localhost", port: 80],
  secret_key_base: "9w9MI64d1L8mjw+tzTmS3qgJTJqYNGJ1dNfn4S/Zm6BbKAmo2vAyVW7CgfI3CpII",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [accepts: ~w(html json)],
  check_origin: false,
  pubsub: [name: InfinityAPS.UI.PubSub, adapter: Phoenix.PubSub.PG2]

import_config "config.priv.exs"
