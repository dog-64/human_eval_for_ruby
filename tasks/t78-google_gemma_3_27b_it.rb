
def hex_key(hex_string)
  count = 0
  hex_string.each_char do |char|
    case char
    when '2', '3', '5', '7', 'B', 'D'
      count += 1
    end
  end
  count
end
