def encode_cyclic(s)
  s.each_char.each_slice(3).map { |a| a.size == 3 ? "#{a[1]}#{a[2]}#{a[0]}" : a.join }.join
end

def decode_cyclic(s)
  s.each_char.each_slice(3).map { |a| a.size == 3 ? "#{a[2]}#{a[0]}#{a[1]}" : a.join }.join
end