def fizz_buzz(n)
  return 0 if n <= 0

  (1...n).count do |i|
    (i % 11 == 0 || i % 13 == 0) && i.to_s.count('7') > 0
  end
end