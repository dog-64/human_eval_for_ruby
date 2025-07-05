
 all the criteria.

Let's double-check the logic with the examples:
*   `lst = [1, 2, 3]`
    *   indexdef sum_squares(lst)
  lst.map.with_index do |n, i|
    if i % 3 == 0
