def make_palindrome(string)
  return string if string == string.reverse

  i = 0
  while i < string.length
    substring = string[0..i]
    reversed_substring = substring.reverse
    if string[i+1..-1] == reversed_substring[1..-1].reverse
      return string + reversed_substring[1..-1]
    end
    i += 1
  end
  string + string[0..-2].reverse
end
def make_palindrome(string)
  return string if string == string.reverse
  (0..string.length).each do |i|
    prefix = string[0...i]
    suffix = prefix.reverse
    if string.end_with?(suffix)
      return string + string[0...i].reverse
    end
  end
  string + string[0...-1].reverse
end