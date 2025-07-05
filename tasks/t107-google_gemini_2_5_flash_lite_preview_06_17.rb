def is_palindrome(num)
  num.to_s == num.to_s.reverse
end

def even_odd_palindrome(n)
  even_count = 0
  odd_count = 0
  (1..n).each do |i|
    if is_palindrome(i)
      if i.even?
        even_count += 1
      else
        odd_count += 1
      end
    end
  end
  [even_count, odd_count]
end