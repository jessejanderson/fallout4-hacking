ExUnit.start
ExUnit.configure(exclude: :pending)

defmodule F4HackingTest do
  use ExUnit.Case, async: true

  test "hack with no words" do
    assert Hack.score_words("") == :error
  end

  test "hack and sort 3 letter words" do
    assert Hack.score_words("foo fat bar")
      == %{foo: 6, fat: 5, bar: 4}
  end
end
