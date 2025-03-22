def search(lst)
  count = Hash.new(0)
  lst.each { |num| count[num] += 1 }
  result = -1
  count.each do |num, freq|
    result = num if num <= freq && num > result
  end
  result
end