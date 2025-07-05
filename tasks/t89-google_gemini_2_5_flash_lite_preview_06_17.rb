def encrypt(s)
  s.chars.map do |char|
    if char >= 'a' && char <= 'z'
      original_position = char.ord - 'a'.ord + 1
      shift_amount = original_position * 2
      new_position = (char.ord - 'a'.ord + shift_amount) % 26
      ('a'.ord + new_position).chr
    else
      char
    end
  end.join
end