defmodule Blumr.Api.UserController do
	use Blumr.Web, :controller
	# require "IEx"
	alias Blumr.User

	def new(conn, _params) do
		changeset = User.changeset(%User{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"user" => user_params}) do
		changeset = User.registration_changeset(%User{}, user_params)
		case Repo.insert(changeset) do 
			{:ok, user} -> 
				conn
				|> put_flash(:info, "#{user.first_name} created!")
				|> redirect(to: user_path(conn, :index))
				# user = put_flash(conn, :info, "#{user.first_name} created!")
				# redirect(user, to: user_path(conn, :index))
			{:error, changeset} -> 
				render(conn, "new.html", changeset: changeset)
		end
	end

  # def create
  #   @user = User.new(user_params.to_h)
  #   @auth_token = jwt_token(@user)
  #   respond_to do |format|
  #     if @user.save
  #       @user.create_pin
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render json: { auth_token: @auth_token, user: @user.build_user_hash, created_at: @user.created_at } }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

	def index(conn, _params) do
		# IEx.pry
		users = Repo.all(User)
		render conn, "index.json", users: users
	end

	def show(conn, %{"id" => id}) do
		user = Repo.get(User, id)
		render conn, "show.json", user: user
	end
end