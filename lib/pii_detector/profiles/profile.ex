defmodule PiiDetector.Profiles.Profile do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [:profile_id, :name, :phone, :email, :driving_license, :aadhaar, :dob, :pan]}
  @primary_key false
  schema "profiles" do
    field(:profile_id, Ecto.UUID, autogenerate: true, primary_key: true)
    field(:name, PiiDetector.Encrypted.Binary)
    field(:name_hash, Cloak.Ecto.SHA256)
    field(:phone, PiiDetector.Encrypted.Binary)
    field(:phone_hash, Cloak.Ecto.SHA256)
    field(:email, PiiDetector.Encrypted.Binary)
    field(:email_hash, Cloak.Ecto.SHA256)
    field(:driving_license, PiiDetector.Encrypted.Binary)
    field(:driving_license_hash, Cloak.Ecto.SHA256)
    field(:aadhaar, PiiDetector.Encrypted.Binary)
    field(:aadhaar_hash, Cloak.Ecto.SHA256)
    field(:dob, PiiDetector.Encrypted.Binary)
    field(:dob_hash, Cloak.Ecto.SHA256)
    field(:pan, PiiDetector.Encrypted.Binary)
    field(:pan_hash, Cloak.Ecto.SHA256)

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:profile_id, :name, :phone, :email, :driving_license, :aadhaar, :dob, :pan])
    |> validate_required([:profile_id])
    |> unique_constraint(:profile_id, name: "profiles_pkey")
    |> put_hashed_fields()
  end

  defp put_hashed_fields(changeset) do
    changeset
    |> put_change(:name_hash, get_field(changeset, :name))
    |> put_change(:phone_hash, get_field(changeset, :phone))
    |> put_change(:email_hash, get_field(changeset, :email))
    |> put_change(:driving_license_hash, get_field(changeset, :driving_license))
    |> put_change(:aadhaar_hash, get_field(changeset, :aadhaar))
    |> put_change(:dob_hash, get_field(changeset, :dob))
    |> put_change(:pan_hash, get_field(changeset, :pan))
  end
end
