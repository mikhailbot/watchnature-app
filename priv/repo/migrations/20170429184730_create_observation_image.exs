defmodule Watchnature.Repo.Migrations.CreateObservationImage do
  use Ecto.Migration

  def change do
    create table(:observation_images) do
      add :public_id, :string
      add :secure_url, :string
      add :signature, :string
      add :source, :string
      add :url, :string
      add :version, :integer
      add :observation_id, references(:observations, on_delete: :nothing)

      timestamps()
    end

    create index(:observation_images, [:observation_id])
  end
end
