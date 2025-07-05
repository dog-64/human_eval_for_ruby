def hex_key(hex_string)
  count = 0
  hex_string.each_char do |char|
    if char =~ /[2357ABC]/
      count += 1
    end
  end
  count
end
