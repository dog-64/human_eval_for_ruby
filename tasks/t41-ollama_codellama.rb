def car_race_collision(n)
  return 0 if n == 0
  return 1 if n == 1
  (n * (n - 1)) / 2
end