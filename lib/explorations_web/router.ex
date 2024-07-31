defmodule ExplorationsWeb.Router do
  use ExplorationsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ExplorationsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExplorationsWeb do
    pipe_through :browser

    get "/", PageController, :home

    # Show all entries
    get "/explorations/all", ExplorationController, :index

    # Show a specific entry
    get "/explorations/:id", ExplorationController, :show

    # Get an existing random entry
    get "/random", ExplorationController, :get_random

    # Get an existing random entry for a specific city
    get "/random/:city", ExplorationController, :get_random

    # form for new entries
    get "/new", ExplorationController, :new

    # create a new entry for a random city
    post "/new", ExplorationController, :create

    # create a new entry for a specific city
    post "/new/:city", ExplorationController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExplorationsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:explorations, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ExplorationsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
