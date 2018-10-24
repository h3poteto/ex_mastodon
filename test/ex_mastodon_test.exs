defmodule ExMastodonTest do
  use ExUnit.Case
  doctest ExMastodon

  test "greets the world" do
    assert ExMastodon.hello() == :world
  end
end
