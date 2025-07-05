def make_palindrome(string)
  return '' if string.empty?

  (0...string.length).each do |i|
    suffix = string[i..-1]
    if suffix == suffix.reverse
      prefix_to_add = string[0...i].reverse
      return string + prefix_to_add
    end
  end
end