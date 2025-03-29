def encode_cyclic(s)
  result = []
  s.chars.each_slice(3) do |group|
    if group.size == 3
      result << group[1] << group[2] << group[0]
    else
      result += group
    end
  end
  result.join
end

def decode_cyclic(s)
  result = []
  s.chars.each_slice(3) do |group|
    if group.size == 3
      result << group[2] << group[0] << group[1]
    else
      result += group
    end
  end
  result.join
end