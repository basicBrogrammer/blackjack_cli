defmodule Game do
  defstruct players: [%Player{name: "player_one"}, %Player{name: "dealer"}], cards: Deck.generate()

  def greet do
    IO.puts("Welcome to exBlackJack.")
  end

  def setup do
    game = %Game{}
    for _ <- 1..(length(game.players) * 2) do
      game |> deal_card(hd(game.players))
    end
  end

  def deal_card(game, player) do
    cards = game.cards |> Deck.pull()
    game
    |> remove_cards(cards)
    |> update_players(Player.add_cards(player, cards))
  end

  defp remove_cards(game, cards) do
    %{ game | cards: game.cards -- cards}
  end

  defp update_players(game, player) do
    players = game.players |> Enum.filter(fn (p) -> p.name != player.name end)

    # ++/2 is slower, but it makes it easier to deal the cards
    %{ game | players: players ++ [player]}
  end
end
