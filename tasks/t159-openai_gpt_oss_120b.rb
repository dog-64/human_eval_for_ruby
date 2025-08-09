def eat(number, need, remaining)
  to_eat = need - number
  to_eat = 0 if to_eat < 0
  eaten_now = to_eat < remaining ? to_eat : remaining
  total_eaten = number + eaten_now
  carrots_left = remaining - eaten_now
  [total_eaten, carrots_left]
end