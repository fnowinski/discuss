defmodule Discuss.CommentsChannel do 
  use Discuss.Web, :channel

  def join(name, _params, socket) do
    IO.puts(name)
    {:ok, %{hey: "there"}, socket}
  end

  def handle_in(name, message, socket) do 
    {:reply, :ok, socket}
  end
end

# defmodule Discuss.CommentChannel do
  # use Discuss.Web, :channel

  # alias Discuss.Repo
  # alias Discuss.User
  # alias Discuss.Presence
  # alias Discuss.Topic

  # def join("comment:lobby", payload, socket) do
    # if authorized?(payload) do
      # {:ok, socket}
    # else
      # {:error, %{reason: "unauthorized"}}
    # end
  # end

  # def handle_in("comment:new", payload, socket) do
    # user = Repo.get(User, socket.assigns.user_id)
  
    # comment_changeset =
      # Discuss.Repo.get(Topic, 6)
      # |> build_assoc(:comments, 
                     # content: payload["comment"], 
                     # user_id: user.id)

    # Discuss.Repo.insert!(comment_changeset)

    # broadcast! socket, "comment:new", %{user: user.email, 
      # comment: payload["comment"]}
    # {:noreply, socket}
  # end

  # defp authorized?(_payload) do
    # true
  # end
# end
