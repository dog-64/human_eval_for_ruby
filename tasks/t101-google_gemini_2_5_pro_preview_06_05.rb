
Let's stick with the regex approach. It's a single method call and clearly expresses the intent: "split by any sequence of commas or whitespace".

The functionLet's consider the `String#scan` method.
- `s.scan(/\w+/)` would find all sequences of "word" characters. This works