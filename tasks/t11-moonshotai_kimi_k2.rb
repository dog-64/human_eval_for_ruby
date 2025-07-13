def string_xor(a, b)
  min_length = [a.length, b.length].min
  result = []
  
  min_length.times do |i|
    bit_a = a[i]
    bit_b = b[i]
    xor_result = (bit_a == bit_b) ? '0' : '1'
    result << xor_result
  end
  
  result.join
end