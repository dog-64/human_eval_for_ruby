def flip_case(string)
  string.chars.map { |char| char =~ /[a-z]/ ? char.upcase : char =~ /[A-Z]/ ? char.downcase : char }.join
end