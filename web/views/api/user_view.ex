defmodule Blumr.Api.UserView do
	use Blumr.Web, :view
	alias Blumr.User 

	# def first_name(%User{name: name}) do
	# 	name |> String.split(" ") |> Enum.at(0)
	# end
  def render("index.json", %{users: users}) do
    %{data: render_many(users, Blumr.Api.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Blumr.Api.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      pin: user.pin,
      email: user.email,
      password: user.password,
      first_name: user.first_name,
      last_name: user.last_name,
      user_name: user.user_name,
      followed_users: user.followed_users,
      pending_users: user.pending_users
    }
  end
end