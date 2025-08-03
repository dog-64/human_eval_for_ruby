

def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = 0
  prod_sign = 1

  arr.each do |num|
    sum_abs += num.abs
    sign = num <=> 0
    prod_sign *= sign
  end

  sum_abs * prod_sign
end