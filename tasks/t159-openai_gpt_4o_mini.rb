def eat(number, need, remaining)
  to_eat = [need - number, remaining].min
  total_eaten = number + to_eat
  carrots_left = remaining - to_eat
  [total_eaten, carrots_left]
end