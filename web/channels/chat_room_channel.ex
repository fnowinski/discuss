# require IEx

# defmodule Discuss.ChatRoomChannel do
  # use Discuss.Web, :channel
  
  # alias Discuss.Repo 
  # alias Discuss.User
  # alias Discuss.Presence

  # def join("room", payload, socket) do
    # if authorized?(payload) do
      # send(self, :after_join)
      # {:ok, socket}
    # else
      # {:error, %{reason: "unauthorized"}}
    # end
  # end

  # def handle_in("message:new", payload, socket) do
    # user = Repo.get(User, socket.assigns.user_id)

    # broadcast! socket, "message:new", %{user: user.email, 
                                        # message: payload["message"]}
    # {:noreply, socket}
  # end

  # def handle_info(:after_join, socket) do
    # user = Repo.get(User, socket.assigns.user_id)

    # {:ok, _} = Presence.track(socket, user.email, %{
      # online_at: inspect(System.system_time(:seconds))
    # })
    # push socket, "presence_state", Presence.list(socket)
    # {:noreply, socket}
  # end

  # defp authorized?(_payload) do
    # true
  # end
# end
