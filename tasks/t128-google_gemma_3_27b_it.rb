
def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = 0
  prod_sign = 1

  arr.each do |num|
    sum_abs += num.abs
    sign = case
           when num > 0 then 1
           when num < 0 then -1
           else 0
           end
    prod_sign *= sign
  end

  return sum_abs * prod_sign
end
