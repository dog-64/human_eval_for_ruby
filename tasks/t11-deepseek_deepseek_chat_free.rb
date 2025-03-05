def string_xor(a, b)
  length = [a.length, b.length].min
  result = ''
  length.times do |i|
    result += (a[i] == b[i] ? '0' : '1')
  end
  result
end