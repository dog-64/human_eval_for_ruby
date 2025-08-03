def encode(message)
  step1 = message.swapcase
  result = ''
  vowels_lower = 'aeiou'
  vowels_upper = 'AEIOU'

  step1.each_char do |char|
    if vowels_lower.include?(char)
      result << (char.ord + 2).chr
    elsif vowels_upper.include?(char)
      result << (char.ord + 2).chr
    else
      result << char
    end
  end

  result
end