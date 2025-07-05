def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.sum(&:abs)
  prod_sign = arr.reduce(1) do |acc, num|
    if num > 0
      acc * 1
    elsif num < 0
      acc * -1
    else
      acc * 0
    end
  end

  sum_abs * prod_sign
end