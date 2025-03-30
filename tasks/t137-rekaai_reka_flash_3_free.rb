
def compare_one(a, b)
  a_num = to_number(a)
  b_num = to_number(b)

  a_num > b_num ? a : b_num > a_num ? b : nil
end

def to_number(value)
  return value if value.is_a?(Numeric)

  converted = value.gsub(/,/, '.').to_f
  converted == converted.to_i ? converted.to_i : converted
end

 