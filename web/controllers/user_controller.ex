defmodule Blumr.UserController do
	use Blumr.Web, :controller
	# require "IEx"
	alias Blumr.User

	def new(conn, _params) do
		changeset = User.changeset(%User{})
		render conn, "new.html", changeset: changeset
	end

	def index(conn, _params) do
		# IEx.pry
		users = Repo.all(User)
		render conn, "index.html", users: users
	end

	def show(conn, %{"id" => id}) do
		user = Repo.get(User, id)
		render conn, "show.html", user: user
	end
end