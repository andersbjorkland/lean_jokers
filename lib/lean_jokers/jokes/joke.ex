defmodule LeanJokers.Jokes.Joke do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jokes" do
    field :dislikes, :integer, default: 0
    field :likes, :integer, default: 0
    field :text, :string
    field :has_liked, :boolean, virtual: true, default: false
    field :has_disliked, :boolean, virtual: true, default: false

    timestamps()
  end

  @doc false
  def changeset(joke, attrs) do
    joke
    |> cast(attrs, [:text, :likes, :dislikes])
    |> validate_required([:text, :likes, :dislikes])
  end
end
