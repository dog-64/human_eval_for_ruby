def fruit_distribution(fruit_string, total_fruits)
  apples_count = 0
  oranges_count = 0

  fruit_string.split(" and ").each do |fruit_part|
    if fruit_part.include?("apples")
      apples_count = fruit_part.split(" apples")[0].to_i
    elsif fruit_part.include?("oranges")
      oranges_count = fruit_part.split(" oranges")[0].to_i
    end
  end

  mango_count = total_fruits - apples_count - oranges_count

  mango_count
end
