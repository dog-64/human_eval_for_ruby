def cycpattern_check(a, b)
  return false if a.empty? || b.empty?

  # create a hash of the characters in the first string
  char_hash = {}
  a.each_char { |c| char_hash[c] = true }

  # check if any character in the second string is in the hash
  b.each_char do |c|
    return true if char_hash[c]
  end

  # check if any character in the second string is a cyclic permutation of a character in the first string
  b.size.times do |i|
    char = b[i]
    (b.size - i).times do |j|
      return true if char == b[(i + j) % b.size]
    end
  end

  false
end