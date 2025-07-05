def string_xor(a, b)
  return '' if a.empty? || b.empty?
  result = ''
  length = [a.length, b.length].min
  (0...length).each do |i|
    if a[i] == b[i]
      result += '0'
    else
      result += '1'
    end
  end
  result
end
