def histogram(text)
  result = Hash.new(0)
  text.each_char do |char|
    result[char] += 1 if char =~ /[a-z]/
  end
  result
end