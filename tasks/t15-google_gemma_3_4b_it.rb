def string_sequence(n)
  result = ""
  (0..n).each do |i|
    result += i.to_s + " "
  end
  result.strip
end
