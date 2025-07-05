def add_even_at_odd(lst)
  sum = 0
  i = 0
  while i < lst.length
    if lst[i] % 2 == 0 && i % 2 != 0
      sum += lst[i]
    end
    i += 1
  end
  sum
end
