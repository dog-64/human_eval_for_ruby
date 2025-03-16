def string_xor(a, b)
  result = ''
  [a.size, b.size].min.times do |i|
    result << (a[i] == b[i] ? '0' : '1')
  end
  result
end