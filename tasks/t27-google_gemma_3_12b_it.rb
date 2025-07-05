def flip_case(string)
  string.chars.map { |char|
    if char.match?(/[a-z]/)
      char.upcase
    elsif char.match?(/[A-Z]/)
      char.downcase
    else
      char
    end
  }.join
end
