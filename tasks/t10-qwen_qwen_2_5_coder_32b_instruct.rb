def make_palindrome(string)
  return string if string == string.reverse

  (0...string.length).each do |i|
    suffix = string[i..-1]
    return string + suffix.reverse if suffix == suffix.reverse
  end

  string + string.reverse[1..-1]
end