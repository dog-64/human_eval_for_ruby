
def make_palindrome(string)
  return string if string == string.reverse

  n = string.length
  (0...n).each do |i|
    candidate = string + string[0..i].reverse
    return candidate if candidate == candidate.reverse
  end
end