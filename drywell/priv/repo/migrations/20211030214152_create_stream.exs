defmodule Drywell.Repo.Migrations.CreateStream do
  use Ecto.Migration

  def change do
    create table(:streams) do
      add :name, :string
      add :flow_value, :integer
      add :flow_unit, :string
      add :height_value, :integer
      add :height_unit, :string
      add :usgs_id, :string
    end
  end
end
