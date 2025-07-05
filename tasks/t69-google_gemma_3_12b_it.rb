def search(lst)
  counts = Hash.new(0)
  lst.each { |x| counts[x] += 1 }
  
  eligible_numbers = []
  counts.each do |num, count|
    if count >= num
      eligible_numbers << num
    end
  end
  
  if eligible_numbers.empty?
    -1
  else
    eligible_numbers.max
  end
end
