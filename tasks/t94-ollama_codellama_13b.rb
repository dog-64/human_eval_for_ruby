def sum_largest_prime_digits(numbers)
  # Найти наибольшее простое число в списке
  largest_prime = numbers.max_by { |num| num.prime? }

  # Если список пуст или не содержит простых чисел, вернуть 0
  return 0 if largest_prime.nil? || !largest_prime.prime?

  # Суммировать цифры наибольшего простого числа
  sum = 0
  largest_prime.to_s.each_char { |digit| sum += digit.to_i }

  return sum
end