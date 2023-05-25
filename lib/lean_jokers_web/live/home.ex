defmodule LeanJokersWeb.Live.Home do
  alias LeanJokers.Jokes
  use LeanJokersWeb, :live_view

  require Logger

  def mount(_params, _session, socket) do
    jokes = LeanJokers.Jokes.Joke
      |> LeanJokers.Repo.all

    socket = socket
      |> assign(:jokes, jokes)

    {:ok, socket}
  end

  def handle_event("like_joke", %{"joke_id" => joke_id} = _params, socket) do
    {joke_id, _} = Integer.parse(joke_id)

    socket_jokes = socket.assigns.jokes
    [socket_joke | _rest ] = Enum.filter(socket_jokes, &(&1.id == joke_id))

    toggled_joke = toggle_data(socket_joke, :like)

    {:ok, _} =
      LeanJokers.Jokes.Joke
        |> LeanJokers.Repo.get(joke_id)
        |> LeanJokers.Jokes.update_joke(%{likes: toggled_joke.likes, dislikes: toggled_joke.dislikes})

    jokes =
      socket.assigns.jokes
        |> Enum.map(fn
          %LeanJokers.Jokes.Joke{id: ^joke_id} -> toggled_joke
          element -> element
        end)

    {:noreply, assign(socket, :jokes, jokes)}
  end

  def handle_event("dislike_joke", %{"joke_id" => joke_id} = _params, socket) do
    {joke_id, _} = Integer.parse(joke_id)

    socket_jokes = socket.assigns.jokes
    [socket_joke | _rest ] = Enum.filter(socket_jokes, &(&1.id == joke_id))

    toggled_joke = toggle_data(socket_joke, :dislike)

    {:ok, _} =
      LeanJokers.Jokes.Joke
        |> LeanJokers.Repo.get(joke_id)
        |> LeanJokers.Jokes.update_joke(%{likes: toggled_joke.likes, dislikes: toggled_joke.dislikes})

    jokes =
      socket.assigns.jokes
        |> Enum.map(fn
          %LeanJokers.Jokes.Joke{id: ^joke_id} -> toggled_joke
          element -> element
        end)

    {:noreply, assign(socket, :jokes, jokes)}
  end

  defp toggle_data(%Jokes.Joke{} = joke, :like) do
    dislikes = if (joke.has_disliked) do
      joke.dislikes - 1
    else
      joke.dislikes
    end

    likes = if (joke.has_liked) do
      joke.likes - 1
    else
      joke.likes + 1
    end

    joke = %{joke | has_liked: !joke.has_liked, likes: likes, dislikes: dislikes}

    if (joke.has_disliked) do
        %{joke | has_liked: false}
    else
      joke
    end
  end

  defp toggle_data(%Jokes.Joke{} = joke, :dislike) do
    dislikes = if (joke.has_disliked) do
      joke.dislikes - 1
    else
      joke.dislikes + 1
    end

    likes = if (joke.has_liked) do
      joke.likes - 1
    else
      joke.likes
    end

    joke = %{joke | has_disliked: !joke.has_disliked, likes: likes, dislikes: dislikes}

    if (joke.has_disliked) do
        %{joke | has_liked: false}
    else
      joke
    end
  end

end
