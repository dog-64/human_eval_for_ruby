def fizz_buzz(n)
  return 0 if n <= 0

  count = 0
  (1...n).each do |num|
    next unless num % 11 == 0 || num % 13 == 0

    count += num.to_s.count('7')
  end
  count
end