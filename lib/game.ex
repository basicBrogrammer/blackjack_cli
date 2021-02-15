defmodule Game do
  defstruct players: [%Player{}], cards: Deck.generate()

  def greet do
    IO.puts("Welcome to exBlackJack.")
  end

  def setup do
    %Game{} |> deal
  end

  def deal(game) do
    cards = game.cards
    game.players
    |> Enum.map(fn (player) ->
      hand = Enum.take_random(cards, 2)
      cards = cards -- hand
      Player.add_cards(player, hand)
    end)
    |> (fn (players) ->
      %{game | cards: cards, players: players}
    end).()
  end

  def deal(game) do
    game.cards
    |> Enum.take_random(2)
    |> (fn (hand) ->
      {game.cards -- hand, hand}
    end).()
  end
end
