def make_palindrome(string)
  return string if string.empty?
  
  (0...string.length).each do |i|
    suffix = string[i..-1]
    if suffix == suffix.reverse
      return string + string[0...i].reverse
    end
  end
  
  string + string[0...-1].reverse
end