def odd_count(strings)
  strings.map do |s|
    count = s.count("13579")
    "the number of odd elements #{count}n the str#{count}ng #{count} of the #{count}nput."
  end
end