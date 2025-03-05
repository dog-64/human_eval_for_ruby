def string_xor(a, b)
  result = ""
  min_length = [a.length, b.length].min
  
  (0...min_length).each do |i|
    if a[i] == b[i]
      result += "0"
    else
      result += "1"
    end
  end
  
  result
end