def search(lst)
  frequency = lst.tally
  result = -1
  frequency.each do |num, count|
    result = num if count >= num && num > result
  end
  result
end