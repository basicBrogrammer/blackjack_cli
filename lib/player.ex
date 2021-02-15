defmodule Player do
  defstruct hand: [], name: ""

  def add_cards(player, cards) do
    %{player | hand: player.hand ++ cards}
  end
end
