defmodule PiiDetector.Repo.Migrations.CreateProfilesTable do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :profile_id, :uuid, primary_key: true
      add :name, :binary
      add :name_hash, :binary
      add :phone, :binary
      add :phone_hash, :binary
      add :email, :binary
      add :email_hash, :binary
      add :driving_license, :binary
      add :driving_license_hash, :binary
      add :aadhaar, :binary
      add :aadhaar_hash, :binary
      add :dob, :binary
      add :dob_hash, :binary
      add :pan, :binary
      add :pan_hash, :binary

      timestamps()
    end
  end
end
