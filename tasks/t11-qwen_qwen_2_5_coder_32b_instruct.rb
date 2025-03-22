def string_xor(a, b)
  min_length = [a.length, b.length].min
  result = ""

  (0...min_length).each do |i|
    result << (a[i] == b[i] ? '0' : '1')
  end

  result
end