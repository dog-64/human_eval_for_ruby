
def sort_even_elements(list)
    even_elements = list.select.with_index { |_, i| i.even? }
    sorted_even_elements = even_elements.sort
    list.map.with_index do |element, i|
        if i.even?
            sorted_even_elements.shift
        else
            element
        end
    end
end