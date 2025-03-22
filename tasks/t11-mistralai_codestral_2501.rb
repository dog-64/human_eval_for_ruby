def string_xor(a, b)
  result = ''
  length = [a.length, b.length].min
  length.times do |i|
    result << (a[i] == b[i] ? '0' : '1')
  end
  result
end