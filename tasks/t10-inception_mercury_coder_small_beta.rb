def make_palindrome(string)
  return string if string == string.reverse

  (0...string.length).each do |i|
    suffix = string[i..-1]
    prefix = string[0...i]
    return string + prefix.reverse if suffix == suffix.reverse
  end

  string + string.reverse
end