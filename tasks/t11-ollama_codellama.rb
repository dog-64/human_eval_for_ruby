def string_xor(a, b)
  result = ""
  a.chars.zip(b.chars).each do |char1, char2|
    result += (char1 == char2 ? "0" : "1")
  end
  return result
end