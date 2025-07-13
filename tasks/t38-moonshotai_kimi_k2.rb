def encode_cyclic(s)
  s.chars.each_slice(3).map do |group|
    if group.size == 3
      [group[1], group[2], group[0]]
    else
      group
    end
  end.flatten.join
end

def decode_cyclic(s)
  s.chars.each_slice(3).map do |group|
    if group.size == 3
      [group[2], group[0], group[1]]
    else
      group
    end
  end.flatten.join
end