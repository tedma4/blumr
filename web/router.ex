defmodule Blumr.Router do
  use Blumr.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Blumr do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    # get "/users", UserController, :index
    # get "/users/:id", UserController, :show

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Blumr do
    pipe_through :api
    resources "/users", Api.UserController
  end
end
