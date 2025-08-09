def string_xor(a, b)
  min_len = [a.length, b.length].min
  result = +''
  i = 0
  while i < min_len
    result << (a[i] == b[i] ? '0' : '1')
    i += 1
  end
  result
end