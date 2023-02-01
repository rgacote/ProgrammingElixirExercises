defmodule Noaa.Airport do
  require Logger
  @user_agent [{"User-agent", "Elixir Chapter 13"}]
  @base_url Application.get_env(:noaa, :base_url)

  def fetch(airport) do
    Logger.info("Fetching weather for airport: #{airport}.")

    airport_url(airport)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def airport_url(airport) do
    url = "#{@base_url}/#{airport}.xml"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, XmlToMap.naive_map(body)}
  end

  def handle_response({:ok, %{status_code: _, body: body}}) do
    {:error, body}
  end
end
