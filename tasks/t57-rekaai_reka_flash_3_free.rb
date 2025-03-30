
def monotonic?(arr)
  return true if arr.size <= 1

  i = 0
  direction = nil

  while i < arr.length - 1
    if arr[i] < arr[i+1]
      direction = :increasing
      break
    elsif arr[i] > arr[i+1]
      direction = :decreasing
      break
    end
    i += 1
  end

  direction.nil? || case direction
                     when :increasing then arr.each_cons(2) { |a, b| a > b && return false }
                     when :decreasing then arr.each_cons(2) { |a, b| a < b && return false }
                     end
end

 