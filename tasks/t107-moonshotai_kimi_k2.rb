def even_odd_palindrome(n)
  even_count = 0
  odd_count = 0
  
  (1..n).each do |num|
    str = num.to_s
    if str == str.reverse
      if num.even?
        even_count += 1
      else
        odd_count += 1
      end
    end
  end
  
  [even_count, odd_count]
end