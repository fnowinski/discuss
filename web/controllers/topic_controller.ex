require IEx

defmodule Discuss.TopicController do 
  use Discuss.Web, :controller

  alias Discuss.{Topic, User, Comment}

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :topic_post_owner when action in [:update, :edit, :delete]  

  def index(conn, _params) do 
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end

  def show(conn, %{"id" => topic_id}) do 
    topic = Repo.one(from t in Topic, where: t.id == ^topic_id,
                     left_join: comments in assoc(t, :comments),
                     left_join: user in assoc(comments, :user),
                     preload: [comments: {comments, user: user}])

    comment_changeset = Comment.changeset(%Comment{})

    render conn, "show.html", topic: topic, comment_changeset: comment_changeset
  end

  def new(conn, _params) do 
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    user_id = get_session(conn, :user_id)
    user    = Repo.get(User, user_id)

    case Topic.create_topic(user, topic) do 
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, topic} ->
        render conn, "new.html", changeset: topic
    end
  end

  def edit(conn, %{"id" => topic_id}) do 
    topic     = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic 
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do 
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do 
      {:ok, _topic} -> 
        conn 
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do 
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn 
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def topic_post_owner(conn, _params) do 
    %{params: %{"id" =>topic_id}} = conn
    user_id = get_session(conn, :user_id)

    if Repo.get(Topic, topic_id).user_id == user_id do 
      conn
    else 
      conn
      |> put_flash(:error, "You cannot edit this topic.")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
