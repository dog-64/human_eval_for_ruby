
negative.
  if x < 0
    raise ArgumentError, "x must be non-negative"
  end

  # The most idiomatic way to convert a number to a different base in
 Ruby is to use the `to_s` method with an argument.
  x.to_s(base)
end
```

The rules state