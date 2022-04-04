defmodule IndistreetApiWeb.Router do
  use IndistreetApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do
    plug IndistreetApi.Plugs.Authentication
  end

  scope "/api", IndistreetApiWeb do
    pipe_through :api

    scope "/v1", V1, as: "v1" do
      resources "/albums", AlbumController, only: [:index, :show]
      post "/signin", UserController, :signin
      post "/signup", UserController, :signup
    end

    scope "/v1", V1, as: "v1" do
      pipe_through [:authentication]

      get "/me", UserController, :me
    end

    scope "/admin", Admin, as: "admin" do
#      if Mix.env() !== :test do
#        pipe_through [:authentication]
#      end

      resources "/albums", AlbumController, except: [:new, :edit]
      resources "/songs", SongController, except: [:new, :edit]
      patch "/toggle-user-authorization/:id", UserController, :toggle_user_authorization
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: IndistreetApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
