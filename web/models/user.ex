defmodule Blumr.User do
	# defstruct [:id, :name, :username, :password]
	use Blumr.Web, :model

  schema "users" do
    field :pin, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :first_name, :string
    field :last_name, :string
    field :user_name, :string
    field :followed_users, {:array, :integer}, default: []
    field :pending_users, {:array, :integer}, default: []
    field :current_location, {:array, :float}, default: []

    timestamps
  end

  @attrs [
    :pin, 
    :email, 
    :password_hash, 
    :first_name, 
    :last_name, 
    :user_name, 
    :followed_users, 
    :pending_users, 
    :current_location
  ]

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name user_name), [])
    |> validate_length(:user_name, min: 1, max: 25)

  end
end