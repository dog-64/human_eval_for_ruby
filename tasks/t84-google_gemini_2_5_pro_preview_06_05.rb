
 -> `12`
    - `12.to_s(2)` -> `"1100"`. Correct.

The implementation seems solid. I
 will now write the final code for the response.def sum_binary_digits(n)
  n.digits.sum.to_s(2)
end