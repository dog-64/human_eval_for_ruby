def eat(number, need, remaining)
  needed_to_eat = [need - number, 0].max
  actual_eaten = [needed_to_eat, remaining].min
  total_eaten = number + actual_eaten
  carrots_left = remaining - actual_eaten
  [total_eaten, carrots_left]
end