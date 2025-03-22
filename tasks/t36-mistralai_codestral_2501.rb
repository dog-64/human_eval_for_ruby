def fizz_buzz(n)
  return 0 if n <= 0

  count = 0
  (1...n).each do |i|
    if i % 11 == 0 || i % 13 == 0
      count += i.to_s.count('7')
    end
  end
  count
end