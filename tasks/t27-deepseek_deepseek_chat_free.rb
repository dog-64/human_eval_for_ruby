def flip_case(string)
  string.chars.map { |char| char == char.downcase ? char.upcase : char.downcase }.join
end