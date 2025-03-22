assert fruit_distribution("5 apples and 6 oranges", 19) == 8
assert fruit_distribution("0 apples and 1 oranges", 3) == 2
assert fruit_distribution("2 apples and 3 oranges", 100) == 95
assert fruit_distribution("100 apples and 1 oranges", 120) == 19
assert fruit_distribution("1 apples and 0 oranges", 1) == 0
assert fruit_distribution("0 apples and 0 oranges", 0) == 0
assert fruit_distribution("10 apples and 20 oranges", 30) == 0
assert fruit_distribution("1000 apples and 1000 oranges", 1000) == 0
assert fruit_distribution("1 apples and 1 oranges", 100) == 98
assert fruit_distribution("5 apples and 6 oranges", 11) == 0

