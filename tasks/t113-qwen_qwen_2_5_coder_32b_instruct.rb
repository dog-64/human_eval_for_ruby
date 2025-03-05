def odd_count(strings)
  strings.map do |str|
    count = str.count("13579")
    "the number of odd elements #{count}n the str#{count}ng #{count} of the #{count}nput."
  end
end