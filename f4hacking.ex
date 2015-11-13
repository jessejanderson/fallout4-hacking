defmodule F4 do

  # def matches_all(map, string) do
  #   Enum.all? map, &F4.match?(&1, string)
  # end


  def hack,       do: hack(IO.gets "What words are available?\n")
  def hack(words) do
    word_list = to_word_list(words)
    add_word(ask_word, Map.new, word_list)
  end


  def add_word(word, word_map, word_list) do
    key = word |> String.rstrip |> String.to_atom
    word_map = Map.put(word_map, key, likeness)
    suggest_words(word_map, word_list)
    add_word(ask_word, word_map, word_list)
  end

  def likeness do
    matching_letters = IO.gets "How much likeness?\n"
    matching_letters |> String.rstrip |> String.to_integer
  end

  def  suggest_words(map, l),                   do: suggest_words(map, l, [])
  defp suggest_words(_, [], matches)            do
    IO.puts "Try one of these words:"
    matches |> Enum.join(" ") |> IO.puts
  end
  defp suggest_words(word_map, [h|t], matches)  do
    if matches_all?(word_map, h), do: matches = [h|matches]
    suggest_words(word_map, t, matches)
  end


  defp ask_word, do: IO.gets "Which word did you try?\n"


  @doc """
  See if a given `string` matches all other options in a given map
  """
  def matches_all?(map, string), do: Enum.all? map, &F4.match?(&1, string)

  @doc """
  Call the `compare` function on a key and a string
  """
  def match?({a, value}, b), do: value === compare(Atom.to_string(a), b)

  @doc """
  Find the amount of common letters between 2 equally lengthed strings
  """
  def  compare(a, b),               do: compare(to_list(a), to_list(b), 0)
  defp compare([], _, acc),         do: acc
  defp compare([a|at], [b|bt], acc) do
    if (a === b), do: acc = acc + 1
    compare(at, bt, acc)
  end


  defp to_list(string), do: String.split(string, "", trim: true)
  defp to_word_list(string), do: String.split(string, [" ", ","], trim: true)

  # GOOOD CODE!!!!! ^^








  # defp add_word(word, value, key)
  #   key = key <> [word => value]
  # end

  # def compare(word, key) do

  # end
end


#   @word_list = []
#   @answer = [{}]
#   def word_list do


#   def solve(word_list) do
#     cond do
#       :solved             -> :answer
#       possible_answers(a) -> :give_leftover_choices
#       true                -> :ask_for_first_result
#     end
#   end
# end



# WORDS = ~w[empty enact swore helps knows names stake marks large price unite stark torch handy]
# IO.puts WORDS
# def correct?
