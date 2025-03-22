def odd_count(strings)
  strings.map.with_index do |string, index|
    odd_count = string.chars.count { _1.to_i.odd? }
    "the number of odd elements #{odd_count}n the str#{odd_count}ng #{index + 1} of the #{index + 1}nput."
  end
end