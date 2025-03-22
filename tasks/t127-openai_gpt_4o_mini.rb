def intersection(interval1, interval2)
  start_point = [interval1[0], interval2[0]].max
  end_point = [interval1[1], interval2[1]].min
  
  length = end_point - start_point + 1
  
  return "NO" if length <= 0
  
  def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  prime?(length) ? "YES" : "NO"
end