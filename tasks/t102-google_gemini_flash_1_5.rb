def choose_num(x, y)
  max_even = -1
  if x <= y
    (x..y).reverse_each do |num|
      if num % 2 == 0
        max_even = num
        break
      end
    end
  end
  max_even
end
