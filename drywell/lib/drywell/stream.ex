defmodule Drywell.Stream do
  use Ecto.Schema

  schema "streams" do
    field :name, :string
    field :flow_value, :integer
    field :flow_unit, :string
    field :height_value, :integer
    field :height_unit, :string
    field :usgs_id, :string
  end

  def changeset(stream, params \\ %{}) do
    stream
    |> Ecto.Changeset.cast(params, [:name, :flow_value, :flow_unit, :height_value, :height_unit, :usgs_id])
    |> Ecto.Changeset.validate_required([:usgs_id])
    |> Ecto.Changeset.validate_length(:usgs_id, min: 8, message: "should be at least 8 characters")
  end
end
