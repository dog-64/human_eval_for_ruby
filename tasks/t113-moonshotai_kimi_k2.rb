def odd_count(strings)
  strings.map do |str|
    odd_count = str.chars.count { |char| char.to_i.odd? }
    "the number of odd elements #{odd_count}n the str#{odd_count}ng #{odd_count} of the #{odd_count}nput."
  end
end