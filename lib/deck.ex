defmodule Deck do
  @suits [:heart, :diamond, :club, :spade]
  @values ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

  def generate do
    @suits
    |> Enum.flat_map(&(build_suit(&1)))
  end

  def pull(deck) do
    deck |> Enum.take_random(1)
  end

  defp build_suit(suit) do
    @values |> Enum.map(fn (value) -> %Card{ suit: suit, value: value } end)
  end
end
