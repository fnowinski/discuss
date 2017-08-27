require IEx

defmodule Discuss.CommentController do 
  use Discuss.Web, :controller

  alias Discuss.{User, Repo, Topic, Comment}

  def create(conn, %{"comment"=> comment_params, "topic_id" => topic_id} = params) do
    comment_changeset = 
      Repo.get(Topic, topic_id)
      |> build_assoc(:comments, 
                     content: comment_params["content"], 
                     user_id: get_session(conn, :user_id))

    case Repo.insert(comment_changeset) do
      {:ok, _comment}         ->
        conn 
        |> redirect(to: topic_path(conn, :show, topic_id))
      {:error, changeset} -> 
        conn
        |> render conn, "show.html", changeset: changeset
    end
  end
end
