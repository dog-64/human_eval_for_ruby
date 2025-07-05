def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.map(&:abs).sum

  product_signs = 1
  arr.each do |num|
    if num > 0
      product_signs *= 1
    elsif num < 0
      product_signs *= -1
    else
      product_signs = 0
      break
    end
  end

  sum_abs * product_signs
end