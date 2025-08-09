def fizz_buzz(n)
  return 0 if n <= 0
  count = 0
  i = 1
  while i < n
    if i % 11 == 0 || i % 13 == 0
      i.to_s.each_char { |c| count += 1 if c == '7' }
    end
    i += 1
  end
  count
end