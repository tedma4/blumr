defmodule Blumr.TestHelpers do
	alias Blumr.Repo

	def insert_user(attrs \\ %{}) do
		changes = Dict.merge(%{
			first_name: "Some",
			last_name: "User",
			user_name: "user#{Base.encode16(:crypto.rand_bytes(8))}",
			email: "#{Base.encode16(:crypto.rand_bytes(8))}@name.com",
			pin: "qwert",
			password: "password"
			}, attrs)
		%Blumr.User{}
		|> Blumr.User.registration_changeset(changes)
		|> Repo.insert!()
	end

	def insert_video(user, attrs \\ %{}) do
		user
		|> Ecto.build_assoc(:videos, attrs)
		|> Repo.insert!()
	end
end