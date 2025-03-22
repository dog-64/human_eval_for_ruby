def compare_one(a, b)
  def to_float(value)
    return value.to_f if value.is_a?(Numeric)
    value.gsub(',', '.').to_f
  end

  float_a = to_float(a)
  float_b = to_float(b)

  return nil if float_a == float_b

  float_a > float_b ? a : b
end