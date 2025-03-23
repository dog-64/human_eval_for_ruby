
def string_xor(a, b)
  result = ''
  min_length = [a.length, b.length].min
  for i in 0...min_length
    if a[i] == b[i]
      result += '0'
    else
      result += '1'
    end
  end
  return result
end
