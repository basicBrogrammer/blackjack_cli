defmodule Game do
  @derive {Inspect, only: [:players]}
  defstruct players: [%Player{name: "player_one"}, %Player{name: "dealer"}], cards: Deck.generate(), finished_players: []

  def greet do
    IO.puts("Welcome to exBlackJack.")
  end

  def play(%{players: []} = game) do
    game
    |> inspect_table()
  end

  def play(game) do
    game
    |> deal()
    |> inspect_table()
    |> turn()
    |> play
  end


  def turn(%{players: [current | players]} = game) do
    IO.puts "Player: #{current.name} your move."
    case IO.gets("Hit or Stay\n") |> String.downcase |> String.trim do
      "hit" -> deal_card(game, current)
      "stay" -> %{game | players: players, finished_players: [current | game.finished_players]}
      _ -> game
    end
  end

  defp inspect_table(%{players: players, finished_players: f_players} = game) do
    IO.write IO.ANSI.reset() <> IO.ANSI.clear() <> IO.ANSI.home()
    if length(players) == 0 do
      IO.puts "Game Over."
    end
    for player <- f_players ++ players do
      IO.puts "#{player.name}'s\n  hand: #{Player.display_hand(player)} |  #{player.total}"
    end
    game
  end

  def deal(%{players: [player | _] } =game) do
    cond do
      Game.cards_dealt(game.players) -> game
      true ->
        game
        |> deal_card(player)
        |> (fn (%{players: [first_player | rest]} = game) -> %{game | players: rest ++ [first_player]} end).()
        |> deal
    end
  end

  def deal_card(%{cards: [card | cards]} = game, player) do
    game
    |> update_players(Player.add_card(player, card))
    |> case do
      game -> %{ game | cards: cards}
    end
  end

  def cards_dealt(players) do
    Enum.reduce(players, 0, fn player, acc -> acc + length(player.hand) end) >= length(players) * 2
  end

  defp update_players(game, player) do
    players = game.players |> Enum.filter(fn (p) -> p.name != player.name end)

    # ++/2 is slower, but it makes it easier to deal the cards
    %{ game | players: [player | players]}
  end
end
