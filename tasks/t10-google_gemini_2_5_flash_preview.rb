def make_palindrome(string)
  return string if string.empty?

  n = string.length
  (0...n).each do |i|
    suffix = string[i..-1]
    if suffix == suffix.reverse
      prefix_to_add = string[0...i].reverse
      return string + prefix_to_add
    end
  end
  string + string[0...-1].reverse
end