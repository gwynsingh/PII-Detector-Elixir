defmodule PiiDetector.Encrypted.Binary do
  use Cloak.Ecto.Binary, vault: PiiDetector.Vault
end
