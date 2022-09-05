defmodule Sponge do
  @moduledoc """
  Documentation for `Sponge`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sponge.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Fetch API response from USGS

  ## Examples

    iex> Sponge.fetch(id)
    USGS response
  """
  def fetch(id) when is_binary(id) and byte_size(id) >= 8 do
    {:ok, _} =
      id
      |> create_url()
      |> get_response()
      |> decode_response()
      |> extract_details()
  end

  def fetch(id) when is_binary id do
    {:error, "Site number length must be string containing no less than 8 numeric digits"}
  end

  def fetch(_) do
    {:error, "Argument must be a string"}
  end

  defp extract_details({:ok, message}) do
    {
      :ok,
      %{
        name: get_site_name(message),
        flow: get_flow_value(message) <> " " <> get_flow_unit(message),
        height: get_height_value(message) <> " " <> get_height_unit(message),
      }
    }
  end

  defp extract_details({:error, _} = response) do
    response
  end

  defp decode_response({:ok, %HTTPoison.Response{status_code: 200}} = {_, response}) do
    {:ok, Poison.decode!(response.body)}
  end

  defp decode_response({_, response})do
    {:error, response.status_code}
  end

  defp create_url(id) do
    "https://waterservices.usgs.gov/nwis/iv/?format=json&sites=#{id}&parameterCd=00060,00065&siteStatus=all"
  end

  defp get_response(url) do
    {:ok, _} =
    url
    |> HTTPoison.get(
         [Accept: "Application/json; Charset=utf-8"],
         ssl: [{:versions, [:"tlsv1.2"]}],
         recv_timeout: 5000
       )
  end

  defp get_site_name(message) do
    message
    |> get_in([
      "value",
      "timeSeries",
      Access.at(0),
      "sourceInfo",
      "siteName"
      ])
  end

  defp get_flow_value(message) do
    message
    |> get_in([
      "value",
      "timeSeries",
      Access.at(0),
      "values",
      Access.at(0),
      "value",
      Access.at(0),
      "value"
    ])
  end

  defp get_flow_unit(message) do
    message
    |> get_in([
      "value",
      "timeSeries",
      Access.at(0),
      "variable",
      "unit",
      "unitCode"
      ])
  end

  defp get_height_value(message) do
    message
    |> get_in([
      "value",
      "timeSeries",
      Access.at(1),
      "values",
      Access.at(0),
      "value",
      Access.at(0),
      "value"
      ])
  end

  defp get_height_unit(message) do
    message
    |> get_in([
      "value",
      "timeSeries",
      Access.at(1),
      "variable",
      "unit",
      "unitCode"
      ])
  end

end
