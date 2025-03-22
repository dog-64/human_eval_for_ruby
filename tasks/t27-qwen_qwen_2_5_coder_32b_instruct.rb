flip_case(string)
  string.chars.map { |char| char.downcase == char ? char.upcase : char.downcase }.join
end