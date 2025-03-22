def compare_one(a, b)
  a_str = a.to_s.gsub(',', '.')
  b_str = b.to_s.gsub(',', '.')

  a_num = a_str.to_f
  b_num = b_str.to_f

  if a_num > b_num
    a.is_a?(String)? a_str : a_num
  elsif a_num < b_num
    b.is_a?(String)? b_str : b_num
  else
    nil
  end
end