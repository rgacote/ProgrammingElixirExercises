defmodule Noaa.MixProject do
  use Mix.Project

  def project do
    [
      app: :noaa,
      name: "NOAAA for Jaffrey, NH",
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Noaa.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison, :elixir_xml_to_map,],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      #{:poison, "~> 5.0"},
      {:elixir_xml_to_map, "~> 3.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:earmark, "~> 1.4", only: :dev, runtime: false},

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
