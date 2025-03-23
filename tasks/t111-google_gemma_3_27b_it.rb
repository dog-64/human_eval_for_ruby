
def histogram(text)
  counts = Hash.new(0)
  text.each_char do |char|
    if char >= 'a' && char <= 'z'
      counts[char] += 1
    end
  end
  
  max_count = 0
  counts.each_value { |count| max_count = [max_count, count].max }
  
  result = {}
  counts.each do |char, count|
    result[char] = count if count == max_count
  end
  
  result
end
