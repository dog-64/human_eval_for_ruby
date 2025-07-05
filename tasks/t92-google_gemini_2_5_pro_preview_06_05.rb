
is_a?(Integer)` is false. The function would return `false`. But `5.0` is a whole number. The problem is likely about the *value* being an integer,
 not the *type*. So, `x == x.to_i` is the better approach.

Condition 1 check: `[x, y, z