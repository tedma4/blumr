defmodule Blumr.SessionController do
	use Blumr.Web, :controller

	def new(conn, _) do
		render conn, "new.html"
	end

	def create(conn, %{"session" => %{"email" => user, "password" => pass}}) do
		case Blumr.Auth.login_by_email_and_pass(conn, user, pass, repo: Repo) do
			{:ok, conn} ->
				conn
				|> put_flash(:info, "Signed in")
				|> redirect(to: page_path(conn, :index))
			{:error, _reason, conn} ->
				conn
				|> put_flash(:error, "Something went wrong, try again")
				|> render("new.html")
		end
	end

	def delete(conn, _) do
		conn
		|> Blumr.Auth.logout()
		|> redirect(to: page_path(conn, :index))
	end
end