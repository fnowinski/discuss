defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel "room", Discuss.ChatRoomChannel

  channel "comment:lobby", Discuss.CommentChannel
  transport :websocket, Phoenix.Transports.WebSocket, timeout: 45_000

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user salt", token, max_age: 1000000) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _reason} -> :error
    end
  end

  def id(_socket), do: nil
end
