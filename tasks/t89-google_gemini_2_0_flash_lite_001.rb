def encrypt(s)
  s.each_char.map do |char|
    index = char.ord - 'a'.ord + 1
    shifted_index = (index * 2) - 1
    'a'.ord + shifted_index > 'z'.ord ? (('a'.ord + shifted_index - 26).chr) : (('a'.ord + shifted_index).chr)
  end.join
end