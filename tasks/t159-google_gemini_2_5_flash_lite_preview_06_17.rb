def eat(number, need, remaining)
  carrots_to_eat = [need - number, remaining].min
  total_eaten = number + carrots_to_eat
  carrots_left = remaining - carrots_to_eat
  [total_eaten, carrots_left]
end