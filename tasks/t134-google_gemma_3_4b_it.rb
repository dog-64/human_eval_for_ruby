def check_last_char_letter?(txt)
  return false if txt.empty?

  last_char = txt[-1]
  rest_of_string = txt[0...-1]

  return false if rest_of_string.strip.empty?

  return false if rest_of_string.last == last_char

  return last_char.match?(/[a-zA-Z]/)
end
