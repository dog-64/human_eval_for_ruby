
_abs, product_of_signs = arr.reduce(initial_state) do |(current_sum, current_prod), n|
    [current_sum +
, current_prod * (n <=> 0)]
  end

  sum_of_abs * product_of_signs
end
```

This single-pass