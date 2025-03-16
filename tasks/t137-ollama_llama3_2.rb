def compare_one(a, b)
  a = a.to_f if a.class == Integer
  b = b.to_f if b.class == Integer
  return nil if a == b

  case a
  when String
    a = a.gsub(',', '.')
  end

  case b
  when String
    b = b.gsub(',', '.')
  end

  a <=> b
end