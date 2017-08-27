defmodule Discuss.Plugs.SetUser do 
  import Plug.Conn 

  alias Discuss.Repo
  alias Discuss.User
  
  def init(_params) do 
  end

  def call(conn, _params) do 
    user_id = get_session(conn, :user_id) 
    token = Phoenix.Token.sign(conn, "user salt", user_id)

    cond do 
      user = user_id && Repo.get(User, user_id) -> 
        assign(conn, :user_id, token)
      true ->  
        assign(conn, :user_id, nil)
    end
  end
end
