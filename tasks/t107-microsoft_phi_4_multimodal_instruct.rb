def even_odd_palindrome(n)
  even_count, odd_count = 0, 0
  (1..n).each do |i|
    str_i = i.to_s
    if str_i == str_i.reverse
      if i.even?
        even_count += 1
      else
        odd_count += 1
      end
    end
  end
  return even_count, odd_count
end