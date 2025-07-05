def has_close_elements(numbers, threshold)
      return false if numbers.length < 2

      sorted_numbers = numbers.sort

      sorted_numbers
