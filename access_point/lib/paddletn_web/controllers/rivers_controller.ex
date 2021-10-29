defmodule PaddletnWeb.RiversController do
  use PaddletnWeb, :controller
  import Sponge
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, "show.html", %{messenger: Sponge.fetch(messenger)})
  end

end
