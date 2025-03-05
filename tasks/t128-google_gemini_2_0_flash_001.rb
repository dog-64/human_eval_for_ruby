def prod_signs(arr)
  return nil if arr.empty?

  abs_sum = 0
  sign_prod = 1

  arr.each do |num|
    abs_sum += num.abs
    sign_prod *= num <=> 0
  end

  abs_sum * sign_prod
end