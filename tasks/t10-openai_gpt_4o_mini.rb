def make_palindrome(string)
  return string if string == string.reverse

  suffix = ''
  (0...string.length).each do |i|
    if string[i..-1] == string[i..-1].reverse
      suffix = string[0...i].reverse
      break
    end
  end
  string + suffix
end