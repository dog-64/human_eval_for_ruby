def maximum(arr, k)
  arr.sort.reverse.take(k).sort
end