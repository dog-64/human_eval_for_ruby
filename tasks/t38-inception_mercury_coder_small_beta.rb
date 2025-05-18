def encode_cyclic(s)
  result = ""
  s.scan(/...?/).each do |group|
    if group.length == 3
      result << group[1..2] + group[0]
    else
      result << group
    end
  end
  result
end

def decode_cyclic(s)
  result = ""
  s.scan(/...?/).each do |group|
    if group.length == 3
      result << group[-1] + group[0..1]
    else
      result << group
    end
  end
  result
end