defmodule Player do
  defstruct hand: [], name: ""

  def add_cards(player, card) do
    %{player | hand: player.hand ++ [card]}
  end

  def display_hand(%{hand: hand} = player) do
    hand
    |> Enum.map(fn (card) -> Card.display(card) end)
    |> Enum.join(" | ")
  end
end
