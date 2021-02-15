defmodule Mix.Tasks.Blackjack do
  use Mix.Task
  def run(_) do
    BlackjackCli.start()
  end
end
