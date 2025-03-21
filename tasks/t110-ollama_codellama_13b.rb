def exchange(lst1, lst2)
    # проверяем, что оба списка не пусты и их элементы являются целыми числами
    raise ArgumentError if lst1.empty? || lst2.empty? || !lst1.all? { |x| x.is_a?(Integer) } || !lst2.all? { |x| x.is_a?(Integer) }
    
    # создаем копии исходных списков
    lst1_copy = lst1.dup
    lst2_copy = lst2.dup
    
    # перебираем элементы первого списка и проверяем, можно ли обменять их с элементами второго списка
    for i in 0..lst1_copy.length - 1
        if lst1_copy[i] % 2 == 0 && lst2_copy.include?(lst1_copy[i])
            # если найден соответствующий элемент в втором списке, обменяем их местами
            lst1_copy[i], lst2_copy = lst2_copy[lst2_copy.index(lst1_copy[i])], lst1_copy[i]
        end
    end
    
    # проверяем, что все элементы первого списка являются чётными
    if lst1_copy.all? { |x| x % 2 == 0 }
        return "YES"
    else
        return "NO"
    end
end