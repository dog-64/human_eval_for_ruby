def string_xor(a, b)
  result = ""
  a_len = a.length
  b_len = b.length
  min_len = [a_len, b_len].min

  (0...min_len).each do |i|
    if a[i] == b[i]
      result += '0'
    else
      result += '1'
    end
  end

  result
end
