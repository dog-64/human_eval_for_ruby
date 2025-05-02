def eat(number, need, remaining)
  required = [need - number, 0].max
  current_eat = [required, remaining].min
  [number + current_eat, remaining - current_eat]
end