def compare_one(a, b)
  if a == b
    return nil
  end

  if a.is_a?(Integer) && b.is_a?(Float)
    return b
  end

  if a.is_a?(Float) && b.is_a?(Integer)
    return b
  end

  if a.is_a?(String) && b.is_a?(String)
    a_float = a.gsub(',', '.')
    b_float = b.gsub(',', '.')
    
    a_num = a_float.to_f
    b_num = b_float.to_f

    if a_num > b_num
      return a
    else
      return b
    end
  end

  if a.is_a?(String) && b.is_a?(Integer)
    return b
  end

  if a.is_a?(Integer) && b.is_a?(String)
    return b
  end

  return a
end
