

  return string if is_palindrome?(string)

  (0...string.length).each do |i|
    suffix = string[i..-1]
    def make_palindrome(string)
  return string if string.empty? || string == string.reverse

  (0...string.length).each do