def eat(number, need, remaining)
  needed = need - number
  if needed <= 0
    total_eaten = number
    carrots_left = remaining
  else
    eaten = [needed, remaining].min
    total_eaten = number + eaten
    carrots_left = remaining - eaten
  end
  [total_eaten, carrots_left]
end