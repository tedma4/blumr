defmodule Blumr.Video do
  use Blumr.Web, :model

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Blumr.User
    belongs_to :category, Blumr.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(url title description)
  @optional_fields ~w(category_id)
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :description])
    # |> validate_required([:url, :title, :description])
  end
end
