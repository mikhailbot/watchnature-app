defmodule Watchnature.ObservationImageTest do
  use Watchnature.ModelCase

  alias Watchnature.ObservationImage

  @valid_attrs %{public_id: "some content", secure_url: "some content", signature: "some content", source: "some content", url: "some content", version: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ObservationImage.changeset(%ObservationImage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ObservationImage.changeset(%ObservationImage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
