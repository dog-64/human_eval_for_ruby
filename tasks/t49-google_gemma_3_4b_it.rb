def modp(n, p)
  if n == 0
    return 1
  end

  result = 1
  base = 2 % p

  loop do
    if n == 0
      break
    end

    if n % 2 == 1
      result = (result * base) % p
    end

    base = (base * base) % p
    n = n / 2
  end

  result
end
