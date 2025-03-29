def encrypt(s)
  s.each_char.with_index do |char, index|
    if char =~ /[a-z]/
      shifted_index = (index * 2 + 1) % 26
      shifted_char = (char.ord - 'a'.ord + shifted_index) % 26 + 'a'.ord
      shifted_char
    end
  end
end