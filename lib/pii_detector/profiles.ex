defmodule PiiDetector.Profiles do
  @moduledoc """
  The Profiles context.
  """
  import Ecto.Query, warn: false

  alias PiiDetector.Profiles.Profile
  alias PiiDetector.Repo

  @doc """
  Gets a single profile.
  """
  def get_profile!(id), do: Repo.get!(Profile, id)

  @doc """
  Creates a profile
  """
  def create_profile(attrs \\ %{}) do
    attrs = Map.put(attrs, :profile_id, UUID.uuid4())

    case %Profile{}
         |> Profile.changeset(attrs)
         |> Repo.insert() do
      {:ok, profile} ->
        {:ok, profile}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a profile
  """
  def update_profile(%Profile{} = profile, attrs) do
    profile
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profile
  """
  def delete_profile(%Profile{} = profile) do
    Repo.delete(profile)
  end
end
