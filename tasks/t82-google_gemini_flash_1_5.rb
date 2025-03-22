def prime_length?(string)
  n = string.length
  return false if n <= 1
  (2...n).each {|i| return false if n % i == 0}
  true
end
