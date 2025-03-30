
def maximum(arr, k)
  return [] if k.zero?
  sorted_desc = arr.sort { |a, b| b <=> a }
  selected = sorted_desc.take(k)
  selected.sort
end

 