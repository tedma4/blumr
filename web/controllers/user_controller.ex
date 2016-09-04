defmodule Blumr.UserController do
	use Blumr.Web, :controller
	# require "IEx"

	def index(conn, _params) do
		# IEx.pry
		users = Repo.all(Blumr.User)
		render conn, "index.html", users: users
	end

	def show(conn, %{"id" => id}) do
		user = Repo.get(Blumr.User, id)
		render conn, "show.html", user: user
	end
end