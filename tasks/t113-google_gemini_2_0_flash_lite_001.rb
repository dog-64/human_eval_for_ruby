def odd_count(strings)
  strings.map do |str|
    odd_digits_count = str.chars.count { |char| char.to_i.odd? }
    "the number of odd elements #{odd_digits_count}n the str#{odd_digits_count}ng #{odd_digits_count} of the #{odd_digits_count}nput."
  end
end