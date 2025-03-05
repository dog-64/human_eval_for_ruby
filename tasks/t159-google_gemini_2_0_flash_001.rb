def eat(number, need, remaining)
  to_eat = need - number
  if to_eat > remaining
    total_eaten = number + remaining
    carrots_left = 0
  else
    total_eaten = need
    carrots_left = remaining - to_eat
  end
  [total_eaten, carrots_left]
end