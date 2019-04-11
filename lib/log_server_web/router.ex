defmodule LogServerWeb.Router do
  use LogServerWeb, :router

  alias LogServerWeb.Context

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

  scope "/", LogServerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # https://github.com/absinthe-graphql/absinthe/blob/master/guides/context-and-authentication.md

  pipeline :graphql do
    plug :fetch_session
    plug :fetch_flash
    plug Context
  end

  scope "/graphiql" do
    pipe_through :graphql
    forward "/", Absinthe.Plug, schema: LogServerWeb.Schema
  end

#  scope "/" do
#    pipe_through :api
#
#    forward "/graphiql", Absinthe.Plug.GraphiQL,
#            schema: LogServerWeb.Schema,
#            interface: :simple,
#            context: %{pubsub: LogServerWeb.Endpoint}
#  end


#  pipeline :api do
#    plug :accepts, ["json"]
#  end
#
#  scope "/api" do
#    pipe_through :api
#
#    forward "/graphiql", Absinthe.Plug.GraphiQL,
#            schema: LogServerWeb.Schema
#
#    forward "/", Absinthe.Plug,
#            schema: LogServerWeb.Schema
#
#  end

  # Other scopes may use custom stacks.
  # scope "/api", LogServerWeb do
  #   pipe_through :api
  # end
end
