def eat(number, need, remaining)
  to_eat = need - number
  if to_eat <= remaining
    total_eaten = number + to_eat
    carrots_left = remaining - to_eat
  else
    total_eaten = number + remaining
    carrots_left = 0
  end
  [total_eaten, carrots_left]
end
