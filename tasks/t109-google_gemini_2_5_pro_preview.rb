
 0: `current_arr = [2, 1]`. Not sorted.
Shift: `current_arr = [1, 2]`
Iteration 1: `current_arr = [1, 2]```ruby
def move_one_ball(arr)
  return true if arr.empty?

  sorted_arr = arr.sort
  return true if arr