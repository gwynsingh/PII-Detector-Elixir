defmodule PiiDetectorWeb.Router do
  use PiiDetectorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PiiDetectorWeb do
    pipe_through :api

    post "/pii/text", PiiController, :pii_text
    post "/pii/mask", PiiController, :pii_mask
    post "/pii/insert", PiiController, :pii_insert
    post "/pii/get", PiiController, :pii_get
  end
end
