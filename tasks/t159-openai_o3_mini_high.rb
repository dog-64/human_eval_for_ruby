def eat(number, need, remaining)
  additional = [need - number, 0].max
  eaten = [additional, remaining].min
  total_eaten = number + eaten
  carrots_left = remaining - eaten
  [total_eaten, carrots_left]
end