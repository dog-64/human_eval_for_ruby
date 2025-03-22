def search(lst)
  # создаем хэш для хранения частот чисел в списке
  freq = Hash.new(0)
  lst.each { |num| freq[num] += 1 }

  # находим наибольшее число, частота которого больше или равна самому числу
  max_freq = -1
  max_num = -1
  freq.each do |num, freq|
    if freq > max_freq
      max_freq = freq
      max_num = num
    end
  end

  # если такого числа нет, возвращаем -1
  return -1 if max_num == -1

  # иначе возвращаем наибольшее число
  return max_num
end