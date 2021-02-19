defmodule Player do
  defstruct hand: [], name: "", total: 0

  def add_card(player, card) do
    %{player | hand: player.hand ++ [card], total: player.total + Card.value(card)}
  end

  def display_hand(%{hand: hand}) do
    hand
    |> Enum.map(fn (card) -> Card.display(card) end)
    |> Enum.join(" ")
  end

  def hand_value(%{hand: hand}) do
    hand
    |> Enum.map(&(Card.value(&1)))
    |> Enum.sort
  end
end
