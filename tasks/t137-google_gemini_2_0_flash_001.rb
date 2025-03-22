def compare_one(a, b)
  a_float = a.to_s.gsub(',', '.').to_f
  b_float = b.to_s.gsub(',', '.').to_f

  if a_float > b_float
    a
  elsif b_float > a_float
    b
  else
    nil
  end
end