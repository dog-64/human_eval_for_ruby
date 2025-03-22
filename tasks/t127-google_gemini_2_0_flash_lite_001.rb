def is_prime(n)
  return false if n <= 1
  return true if n <= 3
  return false if n % 2 == 0 || n % 3 == 0
  i = 5
  while i * i <= n
    return false if n % i == 0 || n % (i + 2) == 0
    i += 6
  end
  true
end

def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  length = (intersection_end - intersection_start) + 1
  length = 0 if length < 0

  if is_prime(length)
    "YES"
  else
    "NO"
  end
end
def is_prime(n)
  return false if n <= 1
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end
def intersection(interval1, interval2)
  start1, end1 = interval1
  start2, end2 = interval2

  intersection_start = [start1, start2].max
  intersection_end = [end1, end2].min

  length = (intersection_end - intersection_start) + 1
  length = 0 if length < 0

  if is_prime(length)
    "YES"
  else
    "NO"
  end
end