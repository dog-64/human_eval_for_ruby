def encrypt(s)
  result = ''
  s.each_char do |c|
    base = 'a'.ord
    current_index = c.ord - base
    new_index = (current_index + 4) % 26
    result << (base + new_index).chr
  end
  result
end