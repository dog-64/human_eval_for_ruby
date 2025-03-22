def fizz_buzz(n)
  return 0 if n <= 0
  (0...n).select { |i| (i % 11 == 0 || i % 13 == 0) }.join.count('7')
end