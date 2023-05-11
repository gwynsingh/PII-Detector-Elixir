defmodule PiiDetectorWeb.TaramsView do
  use PiiDetectorWeb, :view

  @doc """
  Traverses and translates tarams errors.
  """
  def render("error.json", %{errors: errors}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: errors}
  end
end
