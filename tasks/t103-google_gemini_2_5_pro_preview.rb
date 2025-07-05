
  / 2 = 3  R 0
        * 3  / 2 = 1  R 1
        * 1  / 2 = 0  ```ruby
def rounded_avg(n, m)
  return -1 if n > m

  sum = (n..m).sum
  count = m - n