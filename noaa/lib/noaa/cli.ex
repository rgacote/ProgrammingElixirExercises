defmodule Noaa.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the airport lookup.
  """

  @default_airport_code "KAFN"

  @display_keys [
    "credit",
    "location",
    "station_id",
    "latitude",
    "longitude",
    "observation_time_rfc822",
    "temperature_string",
    "relative_humidity",
    "wind_string",
    "pressure_string",
    "dewpoint_string",
    "visibility_mi"
  ]

  def main(argv) do
    run(argv)
    :ok
  end

  def run(argv) do
    argv
    |> parse_args
    |> process
    |> display
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise, it is a GitHub user name, project name, and (optionally)
  the number of entries to format.any()

  Return a tuple of `{ user, project count }` or :help.
  """
  def parse_args(argv) do
    OptionParser.parse(
      argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
    |> args_to_internal_representation()
  end

  @doc """
  Default airport code to Jaffrey Airport-Silver Ranch, NH.
  """
  def args_to_internal_representation([]) do
    {@default_airport_code}
  end

  def args_to_internal_representation([airport_code]) do
    {airport_code}
  end

  def args_to_internal_representation(_) do
    :help
  end

  def process(:help) do
    IO.puts("""
    usage: noaa airport_code
    """)

    System.halt(0)
  end

  def process({airport_code}) do
    Noaa.Airport.fetch(airport_code)
    |> decode_response()
  end

  defp decode_response({:ok, body}) do
    body
  end

  defp decode_response({:error, error}) do
    IO.puts("Error fetching weather: #{error["message"]}")
    System.halt(2)
  end

  @doc """
  Display observation data.

  Don't understand where the "#content" key comes from.
  """
  def display(map) do
    content = map["current_observation"]["#content"]

    for key <- @display_keys do
      IO.puts("#{key}: #{content[key]}")
    end
  end
end
