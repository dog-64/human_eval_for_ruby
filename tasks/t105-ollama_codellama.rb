def by_length(arr)
  # Фильтруем массив, оставляя только числа от 1 до 9 включительно
  filtered_array = arr.select { |num| num >= 1 && num <= 9 }

  # Сортируем отфильтрованный массив в порядке убывания
  sorted_array = filtered_array.sort.reverse

  # Разворачиваем отсортированный массив
  unrolled_array = sorted_array.unshift(nil)

  # Заменяем каждое число в развернутом массиве на его словесное представление
  translated_array = unrolled_array.map do |num|
    case num
    when 1 then "One"
    when 2 then "Two"
    when 3 then "Three"
    when 4 then "Four"
    when 5 then "Five"
    when 6 then "Six"
    when 7 then "Seven"
    when 8 then "Eight"
    when 9 then "Nine"
    else nil
    end
  end

  # Удаляем nil-ы из массива
  translated_array.compact!
end