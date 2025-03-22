def string_xor(a, b)
  len = [a.length, b.length].min
  result = ""
  (0...len).each do |i|
    result += (a[i].to_i ^ b[i].to_i).to_s
  end
  result
end
