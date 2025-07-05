def fizz_buzz(n)
  if n <= 0
    return 0
  end

  count = 0
  (1..n - 1).each do |i|
    if i % 11 == 0 || i % 13 == 0
      str_i = i.to_s
      str_i.each do |digit|
        if digit == '7'
          count += 1
        end
      end
    end
  end

  count
end
