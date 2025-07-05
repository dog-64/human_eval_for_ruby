def compare_one(a, b)
  a_val = begin
    if a.is_a?(String)
      a.tr(',', '.').to_f
    else
      a.to_f
    end
  rescue ArgumentError
    nil
  end

  b_val = begin
    if b.is_a?(String)
      b.tr(',', '.').to_f
    else
      b.to_f
    end
  rescue ArgumentError
    nil
  end

  return nil if a_val.nil? || b_val.nil?

  if a_val == b_val
    nil
  elsif a_val > b_val
    a
  else
    b
  end
end