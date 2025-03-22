def make_palindrome(string)
  return string if string == string.reverse

  for i in 0...string.length
    if string[i..-1] == string[i..-1].reverse
      return string + string[0...i].reverse
    end
  end
end