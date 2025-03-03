assert car_race_collision(0) == 0
assert car_race_collision(1) == 1
assert car_race_collision(2) == 4
assert car_race_collision(3) == 9
assert car_race_collision(5) == 25
assert car_race_collision(10) == 100
assert car_race_collision(100) == 10000
assert_raises(ArgumentError) { car_race_collision(-1) }
assert_raises(ArgumentError) { car_race_collision("abc") }
assert_raises(ArgumentError) { car_race_collision([1,2,3]) }
assert_raises(ArgumentError) { car_race_collision({a: 1})}

