defmodule PiiDetectorWeb.Router do
  use PiiDetectorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PiiDetectorWeb do
    pipe_through :api


    post "/pii/text", PiiController, :pii_text
  end
end
