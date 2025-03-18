def search(lst)
  max = -1
  hash = Hash.new(0)
  lst.each do |x|
    hash[x] += 1
    max = x if hash[x] >= x
  end
  max
end