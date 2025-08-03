
(number, need, remaining)
  to_eat = need - number
  if to_eat <= 0
    [number, remaining]
  else
    actual_eat = [to_eat, remaining].min
    [number + actual_eat, remaining - actual_eat]
  end
end