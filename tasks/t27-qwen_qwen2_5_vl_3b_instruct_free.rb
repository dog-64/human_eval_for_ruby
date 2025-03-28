def flip_case(string)
  string.chars.map { |char| char.upcase if char.ord.between?(65, 90) || char.ord.between?(97, 122) }.join
end