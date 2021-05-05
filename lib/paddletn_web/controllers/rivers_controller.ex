defmodule PaddletnWeb.RiversController do
  use PaddletnWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    {:ok, response} =
      messenger
      |> create_url()
      |> get_response()

    req = Poison.decode!(response.body)

    render(conn, "show.html",
      messenger: %{
        name: List.first(req["value"]["timeSeries"])["sourceInfo"]["siteName"],
        flow:
          List.first(List.first(List.first(req["value"]["timeSeries"])["values"])["value"])[
            "value"
          ] <>
            " " <>
            List.first(req["value"]["timeSeries"])["variable"]["unit"]["unitCode"],
        height:
          List.first(List.first(Enum.at(req["value"]["timeSeries"], 1)["values"])["value"])[
            "value"
          ] <>
            " " <>
            Enum.at(req["value"]["timeSeries"], 1)["variable"]["unit"]["unitCode"]
      }
    )
  end

  def create_url(id) do
    "https://waterservices.usgs.gov/nwis/iv/?format=json&sites=#{id}&parameterCd=00060,00065&siteStatus=all"
  end

  def get_response(url) do
    url
    |> HTTPoison.get(
      [Accept: "Application/json; Charset=utf-8"],
      ssl: [{:versions, [:"tlsv1.2"]}],
      recv_timeout: 5000
    )
  end

  def get_fake() do
    %{
      "declaredType" => "org.cuahsi.waterml.TimeSeriesResponseType",
      "globalScope" => true,
      "name" => "ns1:timeSeriesResponseType",
      "nil" => false,
      "scope" => "javax.xml.bind.JAXBElement$GlobalScope",
      "typeSubstituted" => false,
      "value" => %{
        "queryInfo" => %{
          "criteria" => %{
            "locationParam" => "[ALL:03434500]",
            "parameter" => [],
            "variableParam" => "[00060, 00065]"
          },
          "note" => [
            %{"title" => "filter:sites", "value" => "[ALL:03434500]"},
            %{"title" => "filter:timeRange", "value" => "[mode=LATEST, modifiedSince=null]"},
            %{"title" => "filter:methodId", "value" => "methodIds=[ALL]"},
            %{"title" => "requestDT", "value" => "2021-05-04T04:12:59.961Z"},
            %{"title" => "requestId", "value" => "033d9380-ac8f-11eb-8a3c-2cea7f5e5ede"},
            %{
              "title" => "disclaimer",
              "value" =>
                "Provisional data are subject to revision. Go to http://waterdata.usgs.gov/nwis/help/?provisional for more information."
            },
            %{"title" => "server", "value" => "sdas01"}
          ],
          "queryURL" =>
            "http://waterservices.usgs.gov/nwis/iv/format=json&sites=03434500&parameterCd=00060,00065&siteStatus=all"
        },
        "timeSeries" => [
          %{
            "name" => "USGS:03434500:00060:00000",
            "sourceInfo" => %{
              "geoLocation" => %{
                "geogLocation" => %{
                  "latitude" => 36.1220032,
                  "longitude" => -87.09889379,
                  "srs" => "EPSG:4326"
                },
                "localSiteXY" => []
              },
              "note" => [],
              "siteCode" => [
                %{"agencyCode" => "USGS", "network" => "NWIS", "value" => "03434500"}
              ],
              "siteName" => "HARPETH RIVER NEAR KINGSTON SPRINGS, TN",
              "siteProperty" => [
                %{"name" => "siteTypeCd", "value" => "ST"},
                %{"name" => "hucCd", "value" => "05130204"},
                %{"name" => "stateCd", "value" => "47"},
                %{"name" => "countyCd", "value" => "47021"}
              ],
              "siteType" => [],
              "timeZoneInfo" => %{
                "daylightSavingsTimeZone" => %{
                  "zoneAbbreviation" => "CDT",
                  "zoneOffset" => "-05:00"
                },
                "defaultTimeZone" => %{"zoneAbbreviation" => "CST", "zoneOffset" => "-06:00"},
                "siteUsesDaylightSavingsTime" => true
              }
            },
            "values" => [
              %{
                "censorCode" => [],
                "method" => [%{"methodDescription" => "", "methodID" => 131_283}],
                "offset" => [],
                "qualifier" => [
                  %{
                    "network" => "NWIS",
                    "qualifierCode" => "P",
                    "qualifierDescription" => "Provisional data subject to revision.",
                    "qualifierID" => 0,
                    "vocabulary" => "uv_rmk_cd"
                  }
                ],
                "qualityControlLevel" => [],
                "sample" => [],
                "source" => [],
                "value" => [
                  %{
                    "dateTime" => "2021-05-03T22:00:00.000-05:00",
                    "qualifiers" => ["P"],
                    "value" => "4740"
                  }
                ]
              }
            ],
            "variable" => %{
              "noDataValue" => -999_999.0,
              "note" => [],
              "oid" => "45807197",
              "options" => %{"option" => [%{"name" => "Statistic", "optionCode" => "00000"}]},
              "unit" => %{"unitCode" => "ft3/s"},
              "valueType" => "Derived Value",
              "variableCode" => [
                %{
                  "default" => true,
                  "network" => "NWIS",
                  "value" => "00060",
                  "variableID" => 45_807_197,
                  "vocabulary" => "NWIS:UnitValues"
                }
              ],
              "variableDescription" => "Discharge, cubic feet per second",
              "variableName" => "Streamflow, ft&#179;/s",
              "variableProperty" => []
            }
          },
          %{
            "name" => "USGS:03434500:00065:00000",
            "sourceInfo" => %{
              "geoLocation" => %{
                "geogLocation" => %{
                  "latitude" => 36.1220032,
                  "longitude" => -87.09889379,
                  "srs" => "EPSG:4326"
                },
                "localSiteXY" => []
              },
              "note" => [],
              "siteCode" => [
                %{"agencyCode" => "USGS", "network" => "NWIS", "value" => "03434500"}
              ],
              "siteName" => "HARPETH RIVER NEAR KINGSTON SPRINGS, TN",
              "siteProperty" => [
                %{"name" => "siteTypeCd", "value" => "ST"},
                %{"name" => "hucCd", "value" => "05130204"},
                %{"name" => "stateCd", "value" => "47"},
                %{"name" => "countyCd", "value" => "47021"}
              ],
              "siteType" => [],
              "timeZoneInfo" => %{
                "daylightSavingsTimeZone" => %{
                  "zoneAbbreviation" => "CDT",
                  "zoneOffset" => "-05:00"
                },
                "defaultTimeZone" => %{"zoneAbbreviation" => "CST", "zoneOffset" => "-06:00"},
                "siteUsesDaylightSavingsTime" => true
              }
            },
            "values" => [
              %{
                "censorCode" => [],
                "method" => [%{"methodDescription" => "", "methodID" => 131_285}],
                "offset" => [],
                "qualifier" => [
                  %{
                    "network" => "NWIS",
                    "qualifierCode" => "P",
                    "qualifierDescription" => "Provisional data subject to revision.",
                    "qualifierID" => 0,
                    "vocabulary" => "uv_rmk_cd"
                  }
                ],
                "qualityControlLevel" => [],
                "sample" => [],
                "source" => [],
                "value" => [
                  %{
                    "dateTime" => "2021-05-03T22:00:00.000-05:00",
                    "qualifiers" => ["P"],
                    "value" => "8.29"
                  }
                ]
              }
            ],
            "variable" => %{
              "noDataValue" => -999_999.0,
              "note" => [],
              "oid" => "45807202",
              "options" => %{"option" => [%{"name" => "Statistic", "optionCode" => "00000"}]},
              "unit" => %{"unitCode" => "ft"},
              "valueType" => "Derived Value",
              "variableCode" => [
                %{
                  "default" => true,
                  "network" => "NWIS",
                  "value" => "00065",
                  "variableID" => 45_807_202,
                  "vocabulary" => "NWIS:UnitValues"
                }
              ],
              "variableDescription" => "Gage height, feet",
              "variableName" => "Gage height, ft",
              "variableProperty" => []
            }
          }
        ]
      }
    }
  end
end
