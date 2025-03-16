def prime_length?(string)
  return false if string.empty?
  length = string.size
  (2..length).each do |i|
    break unless length % i == 0
    next if i * i > length
    return false
  end
  true
end