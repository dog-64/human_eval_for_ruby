def max_element(list)
  return nil if list.empty?
  max = list.first
  list.each do |element|
    break if element > max
    max = element
  end
  max
end