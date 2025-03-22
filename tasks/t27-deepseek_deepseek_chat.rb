def flip_case(string)
  string.chars.map { |c| c.match?(/[a-zA-Z]/) ? c.swapcase : c }.join
end