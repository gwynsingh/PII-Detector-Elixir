defmodule PiiDetector.RegexMatcher do
  alias PiiDetector.PiiMasker

  @regexes %{
    phones: ~r"(?<!\d)(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6-9]\d{9}(?![\d])",
    credit_card: ~r/((?:(?:\d{4}[- ]?){3}\d{4}|\d{15,16}))(?![\d])/,
    email:
      ~r/([a-z0-9!#$%&'*+\/=?^_`{|.}~-]+@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)/,
    dates:
      ~r"(?:(?<!\:)(?<!\:\d)[0-3]?\d(?:st|nd|rd|th)?\s+(?:of\s+)?(?:jan\.?|january|feb\.?|february|mar\.?|march|apr\.?|april|may|jun\.?|june|jul\.?|july|aug\.?|august|sep\.?|september|oct\.?|october|nov\.?|november|dec\.?|december)|(?:jan\.?|january|feb\.?|february|mar\.?|march|apr\.?|april|may|jun\.?|june|jul\.?|july|aug\.?|august|sep\.?|september|oct\.?|october|nov\.?|november|dec\.?|december)\s+(?<!\:)(?<!\:\d)[0-3]?\d(?:st|nd|rd|th)?)(?:\,)?\s*(?:\d{4})?|[0-3]?\d[-\./][0-3]?\d[-\./]\d{2,4}"i,
    ip_address:
      ~r"(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)",
    aadhaar: ~r"(?<!\d)[2-9]{1}[0-9]{3}\s[0-9]{4}\s[0-9]{4}(?!\d)",
    pan: ~r"(?<![a-zA-Z\d])[a-zA-Z]{5}[0-9]{4}[a-zA-Z](?![a-zA-Z\d])",
    driving_license: ~r/[a-zA-Z]{2}[-\s]?\d{2}[-\s]?\d{10}/
  }

  def find_pii(document) when is_binary(document) do
    response_map =
      Enum.reduce(@regexes, %{}, fn {reg_key, reg_val}, acc ->
        output =
          case Regex.scan(reg_val, document) do
            [_ | _] = list_output ->
              list_output |> List.flatten() |> Enum.uniq()

            _ ->
              []
          end

        Map.put(acc, reg_key, output)
      end)

    {:ok, response_map}
  end

  def find_pii(_document) do
    {:ok, "Data not in text format"}
  end

  def mask_pii(document) when is_map(document) do
    response_map =
      Enum.reduce(document, %{}, fn {pii_key, pii_val}, acc ->
        Map.put(acc, pii_key, PiiMasker.mask_field(pii_key, pii_val))
      end)

    {:ok, response_map}
  end
end
