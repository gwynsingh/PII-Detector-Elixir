defmodule PiiDetectorWeb.PiiController do
  use PiiDetectorWeb, :controller

  alias PiiDetector.RegexMatcher

  action_fallback(PiiDetectorWeb.FallbackController)

  @text_request_params %{
    document: [type: :string, required: true]
  }

  def pii_text(conn, params) do
    with {:ok, params} <- Tarams.cast(params, @text_request_params),
         {:ok, response} <- RegexMatcher.find_pii(params.document) do
      json(conn, %{potential_pii_data: response})
    end
  end
end
