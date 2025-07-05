def prod_signs(arr)
  if arr.empty?
    return nil
  end

  sum_abs = arr.sum
  product_signs = arr.map { |num| num == 0 ? 0 : num }.reduce(:*)

  sum_abs * product_signs
end
