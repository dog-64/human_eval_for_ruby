def solve(s)
  return s.reverse unless s =~ /[[:alpha:]]/
  parts = s.scan(/[[:alpha:]]+|[^[:alpha:]]+/)
  parts.map! do |part|
    if part =~ /\A[[:alpha:]]+\z/
      if part == part.upcase
        part.swapcase.reverse
      else
        part.swapcase
      end
    else
      part
    end
  end
  parts.join
end