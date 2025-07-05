
  result = counts.select { |letter, count| count == max_frequency }
  # e.g., {"a"=>2, "b"=>2,
 "c"=>1}.select { |k, v| v == 2 }