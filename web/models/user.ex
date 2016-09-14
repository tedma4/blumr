defmodule Blumr.User do
	# defstruct [:id, :name, :username, :password]
	use Blumr.Web, :model
  alias Blumr.User
  alias Blumr.Repo

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
    has_many :videos, Blumr.Video

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
    |> cast(params, ~w(first_name last_name user_name email password pin), [])
    |> validate_length(:user_name, min: 1, max: 25)
    |> validate_length(:first_name, min: 1)
    |> validate_length(:last_name, min: 1)
  end

  def registration_changeset(model, params) do 
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 8, max: 100) 
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do case changeset do
    %Ecto.Changeset{valid?: true, changes: %{password: pass}} -> 
      changeset
      |> put_change( :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
    _ ->
      changeset
    end 
  end

  def search(query) do
    Repo.all from u in User,
      where: ilike(u.first_name, ^"%#{query}%") or
             ilike(u.last_name, ^"%#{query}%") or
             ilike(u.user_name, ^"%#{query}%")
  end

  def search_with_pipes(query) do
    User
    |> where([u], ilike(u.first_name, ^"%#{query}%") or 
                   ilike(u.last_name, ^"%#{query}%") or 
                   ilike(u.user_name, ^"%#{query}%"))
    |> Repo.all()
  end
  # A test Ecto join query
  # Repo.all from u in User,
  #   join: u in assoc(u, :videos),
  #   join: c in assoc(v, :category).
  #   where: c.name == "Comedy"
  #   select: {u, v, c}

end