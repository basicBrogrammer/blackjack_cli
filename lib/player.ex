defmodule Player do
  defstruct hand: [], name: ""

  def add_cards(player, card) do
    %{player | hand: player.hand ++ [card]}
  end
end
