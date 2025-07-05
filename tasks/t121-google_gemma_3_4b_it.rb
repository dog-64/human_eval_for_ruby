def sum_odd_even_pos(lst)
  sum = 0
  i = 0
  while i < lst.length
    if (i % 2 == 0) && (lst[i] % 2 != 0)
      sum += lst[i]
    end
    i += 1
  end
  sum
end
