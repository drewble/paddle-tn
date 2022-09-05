defmodule DrywellTest do
  use ExUnit.Case
  doctest Drywell

  test "greets the world" do
    assert Drywell.hello() == :world
  end
end
