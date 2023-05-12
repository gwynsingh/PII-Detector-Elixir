defmodule PiiDetectorWeb.PiiController do
  use PiiDetectorWeb, :controller

  alias PiiDetector.RegexMatcher
  alias PiiDetector.Profiles

  action_fallback(PiiDetectorWeb.FallbackController)

  @text_request_params %{
    document: [type: :string, required: true]
  }

  @mask_request_params %{
    phone: [type: :string],
    credit_card: [type: :string],
    email: [type: :string],
    ip_address: [type: :string],
    aadhaar: [type: :string],
    pan: [type: :string],
    driving_license: [type: :string]
  }

  @profile_params %{
    name: [type: :string],
    phone: [type: :string],
    email: [type: :string],
    driving_license: [type: :string],
    aadhaar: [type: :string],
    dob: [type: :string],
    pan: [type: :string]
  }

  def pii_text(conn, params) do
    with {:ok, params} <- Tarams.cast(params, @text_request_params),
         {:ok, response} <- RegexMatcher.find_pii(params.document) do
      json(conn, %{potential_pii_data: response})
    end
  end

  def pii_mask(conn, params) do
    with {:ok, params} <- Tarams.cast(params, @mask_request_params),
         {:ok, response} <- RegexMatcher.mask_pii(params) do
      json(conn, %{masked_pii_data: response})
    end
  end

  def pii_insert(conn, params) do
    with {:ok, params} <- Tarams.cast(params, @profile_params),
         {:ok, profile} <- Profiles.create_profile(params) do
      json(conn, %{profile_id: profile.profile_id})
    end
  end

  def pii_get(conn, params) do
    with {:ok, params} <- Tarams.cast(params, %{profile_id: [type: :string, required: true]}),
         profile <- Profiles.get_profile!(params.profile_id) do
      json(conn, %{profile: profile})
    end
  end
end
