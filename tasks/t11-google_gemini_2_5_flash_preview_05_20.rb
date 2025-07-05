def string_xor(a, b)
  result = ''
  length = [a.length, b.length].min
  length.times do |i|
    if a[i] == b[i]
      result += '0'
    else
      result += '1'
    end
  end
  result
end