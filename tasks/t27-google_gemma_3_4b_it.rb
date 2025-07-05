def flip_case(string)
  new_string = ""
  string.each_char do |char|
    if char =~ /[a-zA-Z]/
      if char == char.upcase
        new_string += char.downcase
      else
        new_string += char.upcase
      end
    else
      new_string += char
    end
  end
  new_string
end
