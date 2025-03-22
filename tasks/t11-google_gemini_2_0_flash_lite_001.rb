def string_xor(a, b)
  result = ''
  min_length = [a.length, b.length].min
  min_length.times do |i|
    if a[i] != b[i]
      result += '1'
    else
      result += '0'
    end
  end
  result
end