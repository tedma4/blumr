defmodule Blumr.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :pin, :string
      add :email, :string
      add :password_hash, :string
      add :first_name, :string
      add :last_name, :string
      add :user_name, :string, null: false
      add :followed_users, {:array, :integer}, default: []
      add :pending_users, {:array, :integer}, default: []
      add :current_location, {:array, :float}, default: []

      timestamps
  	end
  	create unique_index(:users, [:user_name])
  	create unique_index(:users, [:email])
  	create index(:users, [:current_location])
  end

end
