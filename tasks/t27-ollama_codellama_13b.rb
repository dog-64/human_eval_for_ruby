def flip_case(string)
  string.chars.map { |c| c =~ /[[:upper:]]/ ? c.downcase : c.upcase }.join
end