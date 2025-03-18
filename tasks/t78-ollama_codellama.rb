def hex_key(hex_string)
  count = 0
  hex_string.each_char do |c|
    if c =~ /[A-F]/i && (c.to_i(16) % 2 == 0 || c.to_i(16) % 3 == 0 || c.to_i(16) % 5 == 0 || c.to_i(16) % 7 == 0)
      count += 1
    end
  end
  return count
end