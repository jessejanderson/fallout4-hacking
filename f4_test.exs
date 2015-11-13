ExUnit.start
ExUnit.configure(exclude: :pending)

defmodule F4HackingTest do
  use ExUnit.Case, async: true

  test ""
end

F4Hacking.hack
#=> What words are available? (Ex: "apple, blast, climb, etc")
foo, bar, bot, fat
#=> Which word did you hack?
foo
#=> How much likeness?
1
#=> Try one of these: BOT, FAT
#=> Which word did you hack?
bot
#=> How much likeness?
1
#=> The correct answer is FAT
