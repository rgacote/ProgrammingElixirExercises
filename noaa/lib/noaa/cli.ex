defmodule Noaa.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the airport lookup.
  """

  @default_airport_code "KAFN"

  #  import Issues.TableFormatter, only: [print_table: 2]

  def main(argv) do
    run(argv)
    :ok
  end

  def run(argv) do
    argv
    |> parse_args
    |> process
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
end
