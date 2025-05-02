def monotonic?(arr)
  arr == arr.sort || arr == arr.sort.reverse
end