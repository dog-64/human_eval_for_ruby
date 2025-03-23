
def flip_case(string)
  result = ""
  string.each_char do |char|
    if char.match?(/[a-z]/)
      result += char.upcase
    elsif char.match?(/[A-Z]/)
      result += char.downcase
    else
      result += char
    end
  end
  result
end
