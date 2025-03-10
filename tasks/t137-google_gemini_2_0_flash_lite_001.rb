def compare_one(a, b)
  a_numeric = begin
    Float(a.to_s.gsub(',', '.'))
  rescue ArgumentError
    nil
  end
  b_numeric = begin
    Float(b.to_s.gsub(',', '.'))
  rescue ArgumentError
    nil
  end

  if a_numeric && b_numeric
    if a_numeric > b_numeric
      return a.is_a?(String) ? a : a_numeric.to_s == a.to_s ? a : a_numeric
    elsif b_numeric > a_numeric
      return b.is_a?(String) ? b : b_numeric.to_s == b.to_s ? b : b_numeric
    else
      return nil
    end
  elsif a_numeric
    if a_numeric > b.to_i
      return a.is_a?(String) ? a : a_numeric.to_s == a.to_s ? a : a_numeric
    elsif b.to_i > a_numeric
      return b
    else
      return nil
    end
  elsif b_numeric
    if b_numeric > a.to_i
      return b.is_a?(String) ? b : b_numeric.to_s == b.to_s ? b : b_numeric
    elsif a.to_i > b_numeric
      return a
    else
      return nil
    end
  else
    if a.to_s == b.to_s
      return nil
    elsif a.to_s > b.to_s
      return a
    else
      return b
    end
  end
end