
def sum_squares(lst)
    lst.map { |x| (x + 0.5).floor ** 2 }.sum
end