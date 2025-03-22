def flip_case(string)
  string.gsub(/[a-zA-Z]/) { |c| c.downcase == c ? c.upcase : c.downcase }