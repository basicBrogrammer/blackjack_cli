defmodule BlackjackCliTest do
  use ExUnit.Case
  doctest BlackjackCli

  test "greets the world" do
    assert BlackjackCli.hello() == :world
  end
end
