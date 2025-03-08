def is_prime(n)
  return false if n < 2
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def intersection(interval1, interval2)
  start = [interval1[0], interval2[0]].max
  finish = [interval1[1], interval2[1]].min
  if start <= finish
    length = finish - start + 1
    return "YES" if is_prime(length)
  end
  "NO"
end