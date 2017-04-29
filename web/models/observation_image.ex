defmodule Watchnature.ObservationImage do
  use Watchnature.Web, :model

  schema "observation_images" do
    field :public_id, :string
    field :secure_url, :string
    field :signature, :string
    field :source, :string
    field :url, :string
    field :version, :integer
    belongs_to :observation, Watchnature.Observation

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:public_id, :secure_url, :signature, :source, :url, :version])
    |> validate_required([:public_id, :secure_url, :signature, :source, :url, :version])
  end
end
