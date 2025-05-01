def prod_signs(arr)
  return nil if arr.empty?

  sum_abs = arr.map(&:abs).sum
  prod_signs = arr.map do |x|
    if x > 0
      1
    elsif x < 0
      -1
    else
      0
    end
  end.reduce(:*)

  sum_abs * prod_signs
end
