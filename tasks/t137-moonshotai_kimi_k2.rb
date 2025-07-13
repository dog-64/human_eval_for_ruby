def compare_one(a, b)
  parse_value = lambda do |val|
    case val
    when String
      val.tr(',', '.').to_f
    when Integer, Float
      val.to_f
    else
      val.to_f
    end
  end

  a_num = parse_value.call(a)
  b_num = parse_value.call(b)

  return nil if a_num == b_num

  if a_num > b_num
    a
  else
    b
  end
end