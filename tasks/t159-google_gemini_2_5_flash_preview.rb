def eat(number, need, remaining)
  needed_to_eat = need - number
  if needed_to_eat <= 0
    [number, remaining]
  else
    eaten_now = [needed_to_eat, remaining].min
    total_eaten = number + eaten_now
    carrots_left = remaining - eaten_now
    [total_eaten, carrots_left]
  end
end
