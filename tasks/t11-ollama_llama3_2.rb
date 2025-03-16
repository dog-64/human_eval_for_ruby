def string_xor(a, b)
  r = ''
  min_len = [a.size, b.size].min
  a_size = a.size
  b_size = b.size
  (0...min_len).each do |i|
    if a[i] == '1' && b[i] == '1'
      r << '0'
    elsif a[i] == '1' || b[i] == '1'
      r << '1'
    else
      r << '0'
    end
  end
  r
end