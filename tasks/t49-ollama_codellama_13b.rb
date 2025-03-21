def modp(n, p)
  return (2**n % p)
end
modp(3, 5) # => 3
modp(1101, 101) # => 2
modp(0, 101) # => 1
modp(3, 11) # => 8
modp(100, 101) # => 1