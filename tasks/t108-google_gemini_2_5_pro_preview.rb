
.

Example: `sum_digits(-10)`
*   `s = "-10"`
*   `current_sum = 0`
*   `num < 0` is true.
*   ```ruby
def count_nums(arr)
  arr.count do |num|
    sum_of_digits(num) > 0
  end
end

def sum