def sort_numbers(numbers)
  numbers.split(' ').map { |word| ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'].index(word) }.sort!.map { |index| ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'][index] }.join(' ')
end