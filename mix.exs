defmodule AshHaikuify.MixProject do
  use Mix.Project

  def project do
    [
      app: :ash_haikuify,
      name: "Ash Haikuify",
      version: "1.0.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: &docs/0,
      package: package(),
      description: description()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ash, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:haikuify, ">= 0.0.0"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        {"README.md", title: "Home"}
      ]
    ]
  end

  defp description do
    "Ash Haikuify is an Ash Framework extension that slugifys resources in haiku style"
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "ash_haikuify",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mithereal/ash_haikuify"}
    ]
  end
end
