def how_many_times(string, substring)
  count = 0
  len = substring.length
  (0..string.length - len).each do |i|
    count += 1 if string[i, len] == substring
  end
  count
end
```ruby
def how_many_times(string, substring)
  string.scan(/(?=#{substring})/).count
end
```ruby
def how_many_times(string, substring)
  return 0 if substring.empty?
  count = 0
  pos = 0
  while pos = string.index(substring, pos)
    count += 1
    pos += 1
  end
  count
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count { |chars| chars.join == substring }
end
```ruby
def how_many_times(string, substring)
  string.split(substring, -1).size - 1
end
```ruby
def how_many_times(string, substring)
  string.scan(substring).size
end
```ruby
def how_many_times(string, substring)
  string.gsub(substring).count
end
```ruby
def how_many_times(string, substring)
  string.enum_for(:scan, substring).count
end
```ruby
def how_many_times(string, substring)
  string.match(substring) ? string.split(substring).size - 1 : 0
end
```ruby
def how_many_times(string, substring)
  string.each_char.with_index.count { |_, i| string[i, substring.length] == substring }
end
```ruby
def how_many_times(string, substring)
  string.chars.each_with_index.count { |_, i| string[i, substring.length] == substring }
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(substring.chars)
end
```ruby
def how_many_times(string, substring)
  string.chars.each_cons(substring.length).count(sub