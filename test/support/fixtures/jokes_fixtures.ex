defmodule LeanJokers.JokesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LeanJokers.Jokes` context.
  """

  @doc """
  Generate a joke.
  """
  def joke_fixture(attrs \\ %{}) do
    {:ok, joke} =
      attrs
      |> Enum.into(%{
        dislikes: 42,
        likes: 42,
        text: "some text"
      })
      |> LeanJokers.Jokes.create_joke()

    joke
  end
end
