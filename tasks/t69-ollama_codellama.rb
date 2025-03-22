def search(lst)
  # создаем хэш для хранения частот чисел
  freq = {}
  lst.each { |num| freq[num] ||= 0; freq[num] += 1 }

  # находим наибольшую частоту
  max_freq = freq.values.max

  # находим число с наибольшей частотой
  num = freq.key(max_freq)

  # если такого числа нет, возвращаем -1
  return -1 if num.nil?

  # иначе возвращаем найденное число
  num
end