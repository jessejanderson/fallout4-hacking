# NEXT: remove words that match likeness

defmodule Fallout do
  def hack,        do: hack IO.gets "Available words? "
  def hack(words)  do
    upcase_words = words |> String.rstrip |> String.upcase
    scored_words = words |> String.rstrip |> score_words
    word_to_try = scored_words |> best_word |> suggested_word
    word_list = words |> String.rstrip |> to_list
    IO.puts "Suggested word: #{word_to_try}"
    likeness = IO.gets "Likeness? "
    if "exit\n" == likeness do
      :ok
    else
      likeness = likeness |> String.rstrip |> String.to_integer
      add_word(word_to_try, likeness, scored_words, String.rstrip(words))
    end
  end

  def suggested_word({word, _val}), do: word

  def add_word(word, likeness, word_map, words) do
    key = word |> String.rstrip |> String.to_atom
    word_map = Map.put(word_map, key, likeness)
    new_words = words |> to_list |> Enum.filter(&(&1 != word)) |> list_to_string
    IO.puts "--"
    IO.puts word
    IO.puts words
    IO.puts new_words
    IO.puts "=="
    hack(new_words)
  end

  def score_words(""),    do: :error
  def score_words(words), do: Enum.zip(word_score_keys(words), word_score_values(words)) |> to_map

  def word_score_keys(words),       do: words |> to_list
  def word_score_values(words),     do: words |> to_list |> Enum.map &(score_word(&1, count_chars(words)))

  def score_word(word, map),        do: word |> String.codepoints |> score_word(map, 0)
  def score_word([h|t], map, acc),  do: score_word(t, map, acc + score_letter(h, map))
  def score_word([], _map, acc),    do: acc

  def score_letter(letter, map),    do: Map.fetch(map, String.to_atom(letter)) |> score_letter
  def score_letter({:ok, value}),   do: value
  def score_letter({:error}),       do: 0

  def best_word(scored_words), do: scored_words |> Enum.max_by fn({_, v}) -> v end

  def to_list(string),              do: String.split(string, [" ", ","], trim: true)
  def to_map(kw_list),              do: Enum.into(kw_list, %{})
  def list_to_string(list),         do: Enum.map(list, &("#{&1} ")) |> List.to_string |> String.rstrip
  def alphabet_map(value \\ 0),     do: Enum.into ?a..?z, %{}, &{String.to_atom(<<&1>>), value}

  def count_chars(s),         do: s |> String.replace(" ", "") |> String.codepoints |> count_chars(alphabet_map)
  def count_chars([], map),   do: map
  def count_chars([h|t], map) do
    map = Map.update!(map, String.to_atom(h), &(&1 +1))
    count_chars(t, map)
  end
end

defmodule F4Old do
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
  defp suggest_words(_, [], result) when length(result) === 1 do
    IO.puts "The answer is:"
    result |> Enum.reverse |> Enum.join(" ") |> String.upcase |> IO.puts
  end
  defp suggest_words(_, [], matches)            do
    IO.puts "Try one of these words:"
    matches |> Enum.reverse |> Enum.join(" ") |> String.upcase |> IO.puts
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
