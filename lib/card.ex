defmodule Card do
  defstruct suit: "", value: ""

  def value(%{value: "J"}), do: 10
  def value(%{value: "Q"}), do: 10
  def value(%{value: "K"}), do: 10
  def value(%{value: "A"}), do: 11
  def value(%{value: value}), do: value

  def display(%{suit: suit, value: value}) do
    IO.ANSI.color_background(15) <> IO.ANSI.color(color_code(suit)) <> "#{suit}#{value}" <> IO.ANSI.reset()
  end

  defp color_code("♥"), do: 9
  defp color_code("♦"), do: 9
  defp color_code("♣"), do: 0
  defp color_code("♠"), do: 0
end
