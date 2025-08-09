def compare_one(a, b)
  parse_value = lambda do |val|
    case val
    when Integer, Float
      val
    when String
      val.tr(',', '.').to_f
    else
      raise ArgumentError, "Unsupported type"
    end
  end

  num_a = parse_value.call(a)
  num_b = parse_value.call(b)

  return nil if num_a == num_b

  num_a > num_b ? a : b
end