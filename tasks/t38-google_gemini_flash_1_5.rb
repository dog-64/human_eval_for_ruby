def encode_cyclic(s)
  return "" if s.empty?
  res = ""
  s.chars.each_slice(3).to_a.each do |slice|
    if slice.size == 3
      res += slice[1] + slice[2] + slice[0]
    else
      res += slice.join
    end
  end
  res
end

def decode_cyclic(s)
  return "" if s.empty?
  res = ""
  s.chars.each_slice(3).to_a.each do |slice|
    if slice.size == 3
      res += slice[2] + slice[0] + slice[1]
    else
      res += slice.join
    end
  end
  res
end
