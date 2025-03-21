def make_palindrome(string)
  return string if string == string.reverse

  (0...string.length).each do |i|
    if string[i..-1] == string[i..-1].reverse
      return string + string[i-1..-1].reverse
    end
  end
end