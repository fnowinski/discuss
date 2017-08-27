defmodule Discuss.ChatroomController do 
  use Discuss.Web, :controller

  plug Discuss.Plugs.RequireAuth when action in [:index]

  def index(conn, _params) do 
    render conn, "index.html"
  end
end
