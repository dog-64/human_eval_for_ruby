def flip_case(string)
  string.chars.map { |char| char == char.upcase ? char.downcase : char.upcase }.join
end