defmodule Blumr.Repo do
  use Ecto.Repo, otp_app: :blumr
  @moduledoc """
	In memory Repository
  """
  # def all(Blumr.User) do
  # 	[
  # 	 %Blumr.User{id: "1", name: "Nick Space", username: "Nicky", password: "password"},
  # 	 %Blumr.User{id: "2", name: "Bill Space", username: "Billy", password: "password"},
  # 	 %Blumr.User{id: "3", name: "Bob Space", username: "Bobby", password: "password"},
  # 	 %Blumr.User{id: "4", name: "Alice Space", username: "Ally", password: "password"},
  # 	 %Blumr.User{id: "5", name: "Ashley Space", username: "Ash", password: "password"},
  # 	 %Blumr.User{id: "6", name: "Libby Space", username: "Libbs", password: "password"}

  #   ]
  # end

  # def all(_module), do: []

  # def get(module, id) do
  # 	Enum.find all(module), fn map -> map.id == id end
  # end

  # def get_by(module, params)  do
  # 	Enum.find all(module), fn map -> 
  # 		Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
  # 	end
  # end
end
