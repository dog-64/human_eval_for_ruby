def string_xor(a, b)
  result = ""
  len = [a.length, b.length].min
  len.times do |i|
    if a[i] == b[i]
      result += '0'
    else
      result += '1'
    end
  end
  result
end