
def search(lst)
  freq = Hash.new(0)
  lst.each { |num| freq[num] += 1 }
  
  max_freq = freq.values.max
  
  max_candidate = -1
  freq.each_key do |x|
    next if x > max_freq
    if freq[x] >= x && x > max_candidate
      max_candidate = x
    end
  end
  
  max_candidate
end