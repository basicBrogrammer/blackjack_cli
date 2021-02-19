defmodule Game do
  @derive {Inspect, only: [:players]}
  defstruct players: [%Player{name: "player_one"}, %Player{name: "dealer"}], cards: Deck.generate(), round: 0, finished_players: []

  def greet do
    IO.puts("Welcome to exBlackJack.")
  end

  def play(%{round: 0} = game) do
    game
    |> deal
    |> (fn game -> %{game | round: 1} end ).()
    |> inspect_table()
    |> play()
  end

  def play(%{round: round, players: [current | players]} = game) do
    IO.puts "Player: #{current.name} your move."
    case IO.gets("Hit or Stay") |> String.downcase |> String.trim do
      "hit" ->
        IO.puts("Player hit.")
        deal_card(game, current)
      "stay" ->
        IO.puts("Player stayed.")
        %{game | players: players, finished_players: [current | game.finished_players]}
      arg ->
        IO.puts("invalid argument: #{arg}")
        game
    end
    |> inspect_table()
    |> play
  end

  def play(%{players: [], finished_players: players}) do
    IO.puts("Game Over.")
    %Game{players: players} |> inspect_table()
  end

  defp inspect_table(%{players: players} = game) do
    for player <- players do
      IO.puts "#{player.name}'s hand: #{Player.display_hand(player)}"
    end
    game
  end

  def deal(%{players: [player | players] } =game) do
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
    %{ game | players: [player | players]}
  end
end
