def flip_case(string)
  string.chars.map do |char|
    if char.match?(/[A-Z]/)
      char.downcase
    elsif char.match?(/[a-z]/)
      char.upcase
    else
      char
    end
  end.join
end