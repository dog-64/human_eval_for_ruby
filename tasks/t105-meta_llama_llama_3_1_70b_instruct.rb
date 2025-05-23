def by_length(arr)
  numbers = { 1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six', 7 => 'Seven', 8 => 'Eight', 9 => 'Nine' }
  arr.filter { |x| x >= 1 && x <= 9 }.sort.reverse.map { |x| numbers[x] }
end