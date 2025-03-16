def sort_array(array)
  return [] if array.empty?
  result = array.dup
  if (array.first + array.last).even?
    result.sort! { |a, b| b <=> a }
  else
    result.sort!
  end
  result
end