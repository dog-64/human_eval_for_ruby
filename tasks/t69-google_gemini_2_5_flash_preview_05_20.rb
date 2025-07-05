def search(lst)
  counts = Hash.new(0)
  lst.each { |num| counts[num] += 1 }

  found_numbers = []
  counts.each do |num, count|
    found_numbers << num if count >= num
  end

  if found_numbers.empty?
    -1
  else
    found_numbers.max
  end
end