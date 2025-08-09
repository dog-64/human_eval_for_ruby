def maximum(arr, k)
  return [] if k == 0
  arr.sort.reverse.take(k).sort
end