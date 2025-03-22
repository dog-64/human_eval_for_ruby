def exchange(lst1, lst2)
  # проверяем, что оба списка не пусты и их элементы являются целыми числами
  raise ArgumentError if lst1.empty? || lst2.empty? || lst1.any? { |e| !e.is_a?(Integer) } || lst2.any? { |e| !e.is_a?(Integer) }

  # создаем копии списков для изменения
  lst1 = lst1.dup
  lst2 = lst2.dup

  # перебираем элементы первого списка и проверяем, можно ли обменять их с элементами второго списка
  for i in 0..lst1.length-1
    for j in 0..lst2.length-1
      if lst1[i] % 2 == 0 && lst2[j] % 2 == 0
        # если оба элемента - чётные, то можно обменять их местами
        lst1[i], lst2[j] = lst2[j], lst1[i]
      end
    end
  end

  # проверяем, что все элементы первого списка являются чётными
  if lst1.all? { |e| e % 2 == 0 }
    return "YES"
  else
    return "NO"
  end
end