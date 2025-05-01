def make_palindrome(string)
  return string if string.empty?

  reversed = string.reverse
  longest_palindrome = string

  (0...string.length).each do |i|
    substring = string[0...i]
    if substring == substring.reverse
      candidate = substring + reversed[i..-1]
      longest_palindrome = candidate if candidate.length > longest_palindrome.length
    end
  end

  longest_palindrome
end
