defmodule Blumr.PageControllerTest do
  use Blumr.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to The Jungle!"
  end
end
