defmodule BlackjackCli do
  @moduledoc """
  Main Module to start the Blackjack Game
  """

  @doc """
  Starts the game
  """
  def start do
    Game.play(%Game{})
  end
end
