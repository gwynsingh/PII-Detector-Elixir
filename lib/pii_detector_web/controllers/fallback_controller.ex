defmodule PiiDetectorWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PiiDetectorWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PiiDetectorWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, {:view_not_found, error}}) do
    errors = %{view: [error]}

    conn
    |> put_status(:not_found)
    |> put_view(PiiDetectorWeb.TaramsView)
    |> render("error.json", errors: errors)
  end

  def call(conn, {:error, errors}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PiiDetectorWeb.TaramsView)
    |> render("error.json", errors: errors)
  end
end
