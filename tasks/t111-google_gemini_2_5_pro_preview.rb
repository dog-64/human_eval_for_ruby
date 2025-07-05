
 2, 'b' => 2}`
7.  Return `result_histogram` which is `{"a"=>2, "b"=>2}`. This matches the example```ruby
def histogram(text)
  return {} if text.empty?

  char_counts = Hash.new(0)
  text.each_