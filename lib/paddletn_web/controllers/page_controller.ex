defmodule PaddletnWeb.PageController do
  use PaddletnWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
