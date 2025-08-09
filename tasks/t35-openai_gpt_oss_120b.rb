def max_element(list)
  return nil if list.empty?
  max = list[0]
  list.each { |x| max = x if x > max }
  max
end