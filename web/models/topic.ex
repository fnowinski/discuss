require IEx;

defmodule Discuss.Topic do
  use Discuss.Web, :model

  alias Discuss.Topic
  alias Discuss.Repo

  schema "topics" do 
    field :title, :string
    belongs_to :user, Discuss.User
    has_many :comments, Discuss.Comment
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

  def create_topic(user, topic) do
    changeset = user
                |> build_assoc(:topics)
                |> Topic.changeset(topic)
   
    Repo.insert(changeset)
  end
end
