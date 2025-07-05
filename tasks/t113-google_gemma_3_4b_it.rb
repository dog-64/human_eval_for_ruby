def odd_count(strings)
  result = []
  strings.each do |str|
    odd_digits = 0
    str.each_char do |char|
      digit = char.to_i
      if digit % 2 != 0
        odd_digits += 1
      end
    end
    result << "the number of odd elements #{odd_digits}n the str#{odd_digits}ng #{odd_digits} of the #{odd_digits}nput."
  end
  result
end
