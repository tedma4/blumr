defmodule Blumr.VideoControllerTest do
	use Blumr.ConnCase
	alias Blumr.Repo
	# require IEx

	setup %{conn: conn} = config do 
		if user_name = config[:login_as] do
			user = insert_user(user_name: user_name)
			conn = assign(conn, :current_user, user)
		else
			:ok
		end
	end

	test "requires user authentication on all actions", %{conn: conn} do
		Enum.each([
			get(conn, video_path(conn, :new)),
			get(conn, video_path(conn, :index)),
			get(conn, video_path(conn, :show, "12")),
			get(conn, video_path(conn, :edit, "12")),
			put(conn, video_path(conn, :update, "12", %{})),
			post(conn, video_path(conn, :create, %{})),
			delete(conn, video_path(conn, :delete, "12")),
			], 
			fn conn ->
					assert html_response(conn, 302)
					assert conn.halted
			end)
	end

	@tag login_as: "teddybear"
	test "lists all user's videos on index", %{conn: conn, user: user} do
		# IEx.pry
		user_video = insert_video(user, title: "new video")
		other_video = insert_video(insert_user(user_name: "other"), title: "another video")

		conn = get conn, video_path(conn, :index)
		assert html_response(conn, 200) =~ ~r/Listing videos/
		assert String.contains?(conn.resp_body, user_video.title)
		refute String.contains?(conn.resp_body, other_video.title)
	end

	alias Blumr.Video
	@valid_attrs %{url: "http://youtu.be", title: "vid", description: "a video"}
	@invalid_attrs %{title: "invalid"}

	defp video_count(query), do: Repo.one(from v in query, select: count(v.id))

	@tag login_as: "teddybear"
	test "creates user video and redirects", %{conn: conn, user: user} do
		conn = post conn, video_path(conn, :create), video: @valid_attrs
		assert redirected_to(conn) == video_path(conn, :index)
		assert Repo.get_by!(Video, @valid_attrs).user_id == user.id
	end

	@tag login_as: "teddybear"
	test "does not create video and renders errors when invalid", %{conn: conn} do
		count_before = video_count(Video)
		conn = post conn, video_path(conn, :create), video: @invalid_attrs
		assert html_response(conn, 200) =~ "check the errors"
		assert video_count(Video) == count_before
	end

	@tag login_as: "teddybear"
	test "authorizes actions against access to other users", %{user: owner, conn: conn} do
		video = insert_video(owner, @valid_attrs)
		non_owner = insert_user(user_name: 'sneaky')
		conn = assign(conn, :current_user, non_owner)
		assert_error_sent :not_found, fn ->
			get(conn, video_path(conn, :show, video))
		end
		assert_error_sent :not_found, fn ->
			get(conn, video_path(conn, :edit, video))
		end
		assert_error_sent :not_found, fn ->
			put(conn, video_path(conn, :update, video, video: @valid_attrs))
		end
		assert_error_sent :not_found, fn ->
			delete(conn, video_path(conn, :delete, video))
		end
	end
end





























































