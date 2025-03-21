
def sum_odd_even_pos(lst)
    lst.each_with_index.reduce(0) do |sum, (num, i)|
        if num.odd? && i.even?
            sum + num
        else
            sum
        end
    end
end