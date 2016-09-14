# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blumr.Repo.insert!(%Blumr.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Faker.start
alias Blumr.User
alias Blumr.Category
alias Blumr.Video
alias Blumr.Repo

for _ <- 1..10000 do 
	%User
	|> User.registration_changeset(
		%{
		  pin: "1234",
		  email: Faker.Internet.email,
		  first_name: Faker.Name.first_name,
		  last_name: Faker.Name.last_name,
		  user_name: Faker.Internet.user_name,
		  followed_users: Enum.to_list(0..10),
		  pending_users: Enum.to_list(0..10),
		  current_location: [ Faker.Address.latitude, Faker.Address.longitude ],
		  password: "password"
		}
	)
end

for category <- ~w(Action Drama Independent Romance Sci-fi Comedy) do
	Repo.get_by!(Category, name: category) ||
	Repo.insert!(%Category{name: category})
end

# for user <- Repo.all(User) do 
# 	user
# 	|> User.registration_changeset(%{password: user.password || "password"})
# 	|> Repo.update!()
# end