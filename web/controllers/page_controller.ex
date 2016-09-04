defmodule Blumr.PageController do
  use Blumr.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
