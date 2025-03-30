
def longest(strings)
  return nil if strings.empty?
  strings.max_by { |s| s.length }
end

 