def encode_cyclic(s)
  result = ""
  s.chars.each_slice(3) do |group|
    if group.length == 3
      result += group[1].to_s + group[2].to_s + group[0].to_s
    else
      result += group.join
    end
  end
  result
end

def decode_cyclic(s)
  result = ""
  s.chars.each_slice(3) do |group|
    if group.length == 3
      result += group[2].to_s + group[0].to_s + group[1].to_s
    else
      result += group.join
    end
  end
  result
end