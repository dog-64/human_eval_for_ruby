def encode(message)
  vowels = %w[a e i o u]
  result = +""
  message.each_char do |ch|
    if ch =~ /[A-Za-z]/
      inverted = ch =~ /[A-Z]/ ? ch.downcase : ch.upcase
      if vowels.include?(inverted.downcase)
        replaced = (inverted.ord + 2).chr
        result << replaced
      else
        result << inverted
      end
    else
      result << ch
    end
  end
  result
end