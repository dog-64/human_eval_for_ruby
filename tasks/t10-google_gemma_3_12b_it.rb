def make_palindrome(string)
  return string if string.empty?
  return string if string == string.reverse
  
  (1..string.length).each do |i|
    suffix = string[i..-1]
    candidate = string + suffix.reverse
    return candidate if candidate == candidate.reverse
  end
  
  string + string.reverse
end
