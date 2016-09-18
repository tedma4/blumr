defmodule Blumr.AuthTest do
	use Blumr.ConnCase
	alias Blumr.User
	alias Blumr.Auth

	setup %{conn: conn} do
		conn = 
		  conn
		  |> bypass_through(Blumr.Router, :browser)
		  |> get("/")
		{:ok, %{conn: conn}}
	end

	test "authenticate_user halts when there is no current_user", %{conn: conn} do
		conn = Auth.authenticate_user(conn, [])
		assert conn.halted
	end

	test "authenticate_user continues when there is a current_user", %{conn: conn} do
		conn = 
		  conn
		  |> assign(:current_user, %User{})
		  |> Auth.authenticate_user([])

		refute conn.halted
	end
end