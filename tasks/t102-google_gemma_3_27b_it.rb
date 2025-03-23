def choose_num(x, y)
  start = [x, y].min
  finish = [x, y].max

  largest_even = -1

  (start..finish).each do |num|
    if num.even?
      largest_even = num
    end
  end

  return largest_even
end