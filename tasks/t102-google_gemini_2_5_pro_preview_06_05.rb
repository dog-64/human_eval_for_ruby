
 no even number was found in the loop
  -1
end
```

This looks correct and idiomatic. It handles all the cases.

Another approach:
1. Check if `x > y`,def choose_num(x, y)
  (x..y).select(&:even?).max || -1
end