
def sort_array(array)
  copied = array.dup
  sum = array.empty? ? 0 : array.first + array.last
  ascending = sum.odd?
  ascending ? copied.sort : copied.sort { |a, b| b <=> a }
end

 