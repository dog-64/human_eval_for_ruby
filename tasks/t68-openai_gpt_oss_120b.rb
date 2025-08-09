def pluck(arr)
  min_val = nil
  min_idx = nil
  arr.each_with_index do |v, i|
    next unless v.even?
    if min_val.nil? || v < min_val
      min_val = v
      min_idx = i
    end
  end
  min_val.nil? ? [] : [min_val, min_idx]
end