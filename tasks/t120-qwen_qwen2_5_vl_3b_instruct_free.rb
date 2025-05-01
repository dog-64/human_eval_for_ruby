def maximum(arr, k)
  arr.sort_by! { |num| -num }[-k..-1]
end
