def even_odd_palindrome(n)
  even = 0
  odd = 0
  (1..n).each do |i|
    str = i.to_s
    next unless str == str.reverse
    if i.even?
      even += 1
    else
      odd += 1
    end
  end
  [even, odd]
end