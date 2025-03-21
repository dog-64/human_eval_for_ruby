def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  if intersection_start > intersection_end
    return "NO"
  end

  intersection_length = intersection_end - intersection_start + 1

  def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).each do |i|
      return false if num % i == 0
    end
    true
  end

  prime?(intersection_length) ? "YES" : "NO"
end