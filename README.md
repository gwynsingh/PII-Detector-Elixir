# PiiDetector

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
# PII-Detector-Elixir

1. Start server with mix phx.server
2. Call Pii detection api . Example 
```
 curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"document":"My name is John Doe. My phone number is 9414175514 . My credit card number is 1234-5678-9012-3456 . My email is john.doe@example.in. My date of birth is 30th July 1992. My ip is 192.168.0.1. And my aadhar is 2345 4567 5829 . My Pan is ABCJH9034S . My dl is HR-0619850034761 "}' \
  http://localhost:4000/api/pii/text
```
3. Response : 
```
  {
    "potential_pii_data": {
        "aadhaar": [
            "2345 4567 5829"
        ],
        "credit_card": [
            "1234-5678-9012-3456"
        ],
        "dates": [
            "30th Jul"
        ],
        "driving_license": [
            "HR-061985003476"
        ],
        "email": [
            "john.doe@example.in"
        ],
        "ip_address": [
            "192.168.0.1"
        ],
        "pan": [
            "ABCJH9034S"
        ],
        "phones": [
            "9414175514"
        ]
    }
}
```

