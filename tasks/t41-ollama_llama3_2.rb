def car_race_collision(n)
  (n * n).downto(1) { |i| i / 2 + 1 } .sum
end