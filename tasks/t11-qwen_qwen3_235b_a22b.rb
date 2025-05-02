def string_xor(a, b)
  result = ""
  min = [a.size, b.size].min
  min.times do |i|
    bit_a = a[i].to_i
    bit_b = b[i].to_i
    result << (bit_a ^ bit_b).to_s
  end
  result
end