def to_numeric(value)
  case value
  when String
    value.tr(',', '.').to_f
  else
    value.to_f
  end
end

def compare_one(a, b)
  a_num = to_numeric(a)
  b_num = to_numeric(b)
  if a_num > b_num
    a
  elsif b_num > a_num
    b
  else
    nil
  end
end