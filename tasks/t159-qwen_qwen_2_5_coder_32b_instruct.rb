def eat(number, need, remaining)
  additional = [need - number, remaining].min
  total_eaten = number + additional
  carrots_left = remaining - additional
  [total_eaten, carrots_left]
end