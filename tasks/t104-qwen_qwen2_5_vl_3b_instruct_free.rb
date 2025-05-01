def unique_digits(numbers)
  numbers.select { |num| num.to_s.chars.all? { |c| c =~ /[13579]/ } }
end
