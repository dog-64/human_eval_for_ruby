def fizz_buzz(n)
  c = 0
  (1..n).each do |i|
    break if i > n
    s = i.to_s
    next if s.include?('7')
    if i % 11 == 0 || i % 13 == 0
      c += 1
    end
  end
  c
end