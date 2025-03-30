
def intersection(interval1, interval2)
  a1, b1 = interval1
  a2, b2 = interval2

  start = [a1, a2].max
  end = [b1, b2].min

  length = start > end ? 0 : end - start + 1

  is_prime?(length) ? "YES" : "NO"
end

def is_prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n).to_i).none? { |i| n % i == 0 }
end

 