def int_to_mini_roman(number)
  raise ArgumentError, "Input must be a positive integer" unless number.is_a?(Integer) && number > 0
  raise ArgumentError, "Input must be between 1 and 1000 (inclusive)" unless number >= 1 && number <= 1000

  roman = ""
  while number > 0
    case number % 10
    when 1
      roman << "i"
    when 2
      roman << "ii"
    when 3
      roman << "iii"
    when 4
      roman << "iv"
    when 5
      roman << "v"
    when 6
      roman << "vi"
    when 7
      roman << "vii"
    when 8
      roman << "viii"
    when 9
      roman << "ix"
    end
    number /= 10
  end

  return roman.downcase
end