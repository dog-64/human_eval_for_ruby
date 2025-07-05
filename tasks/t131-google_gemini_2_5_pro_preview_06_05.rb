
4, 2].select(&:odd?)` -> `[]`
3.  `[].reduce(:*)` -> `nil`. We need to return 0.

Let's trace the
logic for `n = 235`:
1.  `n.digits` -> `[5