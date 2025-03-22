
def fruit_distribution(fruit_string, total_fruits)
    x, y = fruit_string.split(" and ").map(&:to_i)
    total_fruits - (x + y)
end