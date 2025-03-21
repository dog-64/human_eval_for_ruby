def sorted_list_sum(lst)
    # удаляем строки нечетной длины из списка
    lst = lst.select { |s| s.length % 2 == 0 }
    
    # сортируем список по длине строк в порядке возрастания
    lst = lst.sort_by { |s| s.length }
    
    # возвращаем отсортированный список
    return lst
end