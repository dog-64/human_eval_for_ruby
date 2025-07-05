def make_palindrome(string)
  return string if string.empty?
  return string if string == string.reverse

  (0...string.length).each do |i|
    suffix = string[i..-1]
    if suffix == suffix.reverse
      prefix_to_add = string[0...i].reverse
      return string + prefix_to_add
    end
  end
  string + string[0...-1].reverse
end