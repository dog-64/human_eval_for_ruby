def fizz_buzz(n)
  return 0 if n <= 0
  (1...n).count { |i| (i % 11 == 0 || i % 13 == 0) && i.to_s.include?('7') }
end