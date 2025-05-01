def compare_one(a, b)
  a_val = a.is_a?(String) ? a.gsub(',', '.').to_f : a.to_f
  b_val = b.is_a?(String) ? b.gsub(',', '.').to_f : b.to_f

  if a_val > b_val
    a
  elsif b_val > a_val
    b
  else
    nil
  end
end