def is_prime(n)
  return false if n <= 1
  return true if n == 2
  return false if n.even?
  i = 3
  while i * i <= n
    return false if n % i == 0
    i += 2
  end
  true
end

def intersection(interval1, interval2)
  a1, b1 = interval1
  a2, b2 = interval2
  start = [a1, a2].max
  finish = [b1, b2].min
  return "NO" if start > finish
  length = finish - start + 1
  is_prime(length) ? "YES" : "NO"
end