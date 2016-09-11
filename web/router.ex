defmodule Blumr.Router do
  use Blumr.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Blumr.Auth, repo: Blumr.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Blumr do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/videos", VideoController
    # get "/users", UserController, :index
    # get "/users/:id", UserController, :show

    get "/", PageController, :index
  end

  # This scope is for piping the video stuff to use the authenicate_user plug
  scope "/manage", Blumr do
    pipe_through [:browser, :authenticate_user]
    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  scope "/api", Blumr do
    pipe_through :api
    resources "/users", Api.UserController
  end
end
