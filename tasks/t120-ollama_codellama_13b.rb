def maximum(arr, k)
  return [] if arr.empty? || k == 0

  sorted_arr = arr.sort
  max_k = sorted_arr[-k..-1]

  return max_k
end