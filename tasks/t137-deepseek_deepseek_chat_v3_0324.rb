def compare_one(a, b)
  convert = lambda do |x|
    case x
    when String
      x.gsub(',', '.').to_f
    else
      x.to_f
    end
  end

  a_num = convert.call(a)
  b_num = convert.call(b)

  return nil if a_num == b_num

  if a_num > b_num
    a
  else
    b
  end
end