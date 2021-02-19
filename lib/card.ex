defmodule Card do
  defstruct suit: "", value: ""

  def value(cards) do
    cards |> Enum.reduce(0, fn (card,acc) -> acc + card.value end)
  end

  def display(%{suit: suit, value: value}) do
    "#{suit}#{value}"
  end
end
