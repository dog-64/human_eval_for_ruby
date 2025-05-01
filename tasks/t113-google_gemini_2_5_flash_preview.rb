def odd_count(strings)
  strings.map do |str|
    count = str.chars.count { |char| char.to_i.odd? }
    "the number of odd elements #{count}n the str#{count}ng #{count} of the #{count}nput."
  end
end
