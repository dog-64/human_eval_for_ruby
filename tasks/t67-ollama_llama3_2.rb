def fruit_distribution(fruit_string, total_fruits)
  apples, oranges = *fruit_string.split(' and ').map(&:split).flat_map { |s| s.to_i }
  (total_fruits - apples - oranges) / 1
end