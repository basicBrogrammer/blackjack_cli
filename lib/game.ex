defmodule Game do
  defstruct players: [%Player{name: "player_one"}, %Player{name: "dealer"}], cards: Deck.generate()

  def greet do
    IO.puts("Welcome to exBlackJack.")
  end

  def deal(game) do
    cond do
      Game.cards_dealt(game.players) -> game
      true -> game |> deal_card(hd(game.players)) |> deal
    end
  end

  def deal_card(%{cards: [card | cards]} = game, player) do
    game
    |> update_players(Player.add_cards(player, card))
    |> case do
      game -> %{ game | cards: cards}
    end
  end

  def cards_dealt(players) do
    Enum.reduce(players, 0, fn player, acc -> acc + length(player.hand) end) == length(players) * 2
  end

  defp update_players(game, player) do
    players = game.players |> Enum.filter(fn (p) -> p.name != player.name end)

    # ++/2 is slower, but it makes it easier to deal the cards
    %{ game | players: players ++ [player]}
  end
end
