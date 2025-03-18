def sort_even_elements(list)
  new_list = []
  list.each_with_index do |element, index|
    if index % 2 == 0
      new_list << element
    end
  end
  new_list.sort!
end