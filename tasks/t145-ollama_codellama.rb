def order_by_points(nums)
  # создаем новый список, где каждое число заменено на его сумму цифр и индекс в исходном списке
  nums_with_index = nums.each_with_index.map { |n, i| [n.to_s.chars.sum(&:to_i), i] }
  
  # сортируем новый список по сумме цифр в порядке возрастания
  nums_with_index.sort_by { |(sum, _)| sum }
end