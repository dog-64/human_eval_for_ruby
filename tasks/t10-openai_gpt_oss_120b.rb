def make_palindrome(string)
  rev = string.reverse
  n = string.length
  match_len = 0
  n.downto(0) do |i|
    if string[-i, i] == rev[0, i]
      match_len = i
      break
    end
  end
  string + rev[match_len..-1].to_s
end