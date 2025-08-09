def maximum(arr, k)
  sorted = arr.sort
  sorted[-k, k] || []
end