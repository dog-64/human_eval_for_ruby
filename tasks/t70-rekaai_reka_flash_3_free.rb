
def strange_sort_list(lst)
  return [] if lst.empty?
  copy = lst.dup
  result = []
  step = 0
  while !copy.empty?
    val = step.even? ? copy.min : copy.max
    result << val
    copy.delete(val)
    step += 1
  end
  result
end

 