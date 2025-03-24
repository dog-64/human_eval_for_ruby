def fizz_buzz(n)
  return 0 if n <= 0
  count = 0
  (1..(n - 1)).each do |i|
    count += 1 if i % 11 == 0 || i % 13 == 0 && i.to_s.include?('7')
  end
  count
end