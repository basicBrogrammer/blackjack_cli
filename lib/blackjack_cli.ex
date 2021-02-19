defmodule BlackjackCli do
  @moduledoc """
  Main Module to start the Blackjack Game
  """

  @doc """
  Starts the game
  """
  def start do
    %Game{cards: Deck.generate()} |> Game.play
  end
end
