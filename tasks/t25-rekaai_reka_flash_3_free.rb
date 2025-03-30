
def factorize(n)
  return [] if n == 1

  factors = []
  current = n.abs

  if current != 1
    factors << -1 if n.negative?
    current = current.positive? ? current : current.abs

    i = 2
    while i * i <= current
      while current % i == 0
        factors << i
        current /= i
      end
      i += 1
    end

    factors << current if current > 1
  end

  factors
end

 